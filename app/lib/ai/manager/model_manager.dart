/// Model Manager — handles model downloads, installation, and lifecycle.
/// Includes memory pressure handling for automatic model unloading.
library;

import 'dart:async';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/model_catalog_entry.dart';
import '../models/hardware_profile.dart';
import '../models/model_catalog.dart';

class ModelManager {
  final Directory _modelsDir;
  final HardwareProfile _hardware;
  final _downloadProgressController =
      StreamController<Map<String, DownloadProgress>>.broadcast();
  final Map<String, DownloadProgress> _downloads = {};
  VoidCallback? _onMemoryPressure;

  ModelManager._({
    required Directory modelsDir,
    required HardwareProfile hardware,
  }) : _modelsDir = modelsDir,
       _hardware = hardware {
    _setupMemoryPressureListener();
  }

  void _setupMemoryPressureListener() {
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == 'memoryPressure') {
        _onMemoryPressure?.call();
      }
      return null;
    });
  }

  void setOnMemoryPressure(VoidCallback callback) {
    _onMemoryPressure = callback;
  }

  /// Create and initialize the model manager.
  static Future<ModelManager> create() async {
    final appDir = await getApplicationDocumentsDirectory();
    final modelsDir = Directory(p.join(appDir.path, 'models'));
    if (!await modelsDir.exists()) {
      await modelsDir.create(recursive: true);
    }

    final hardware = await HardwareProfile.detect();
    return ModelManager._(modelsDir: modelsDir, hardware: hardware);
  }

  HardwareProfile get hardware => _hardware;
  Directory get modelsDir => _modelsDir;
  Stream<Map<String, DownloadProgress>> get downloadsStream =>
      _downloadProgressController.stream;
  Map<String, DownloadProgress> get downloads => Map.unmodifiable(_downloads);

  /// Get all installed models.
  Future<List<ModelCatalogEntry>> getInstalledModels() async {
    final entries = <ModelCatalogEntry>[];
    if (await _modelsDir.exists()) {
      await for (final entity in _modelsDir.list()) {
        if (entity is File && entity.path.endsWith('.gguf')) {
          final stat = await entity.stat();
          final name = p.basenameWithoutExtension(entity.path);
          entries.add(
            ModelCatalogEntry(
              id: name,
              name: name,
              description: 'Installed model',
              url: '',
              sizeBytes: stat.size,
              quantization: 'unknown',
              supportedTasks: ['chat'],
              minRamMb: 1024,
              recommendedRamMb: 2048,
              license: 'unknown',
              architecture: 'unknown',
              family: 'unknown',
            ),
          );
        }
      }
    }
    return entries;
  }

  /// Get the path for a model.
  String getModelPath(String modelId) =>
      p.join(_modelsDir.path, '$modelId.gguf');

  /// Check if a model is installed.
  Future<bool> isInstalled(String modelId) async {
    final path = getModelPath(modelId);
    return await File(path).exists();
  }

  /// Delete a model.
  Future<void> deleteModel(String modelId) async {
    final path = getModelPath(modelId);
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    final partFile = File('$path.part');
    if (await partFile.exists()) {
      await partFile.delete();
    }
  }

  /// Download a model from the catalog with resume support and SHA256 verification.
  Future<void> downloadModel(
    ModelCatalogEntry model, {
    void Function(double progress)? onProgress,
  }) async {
    final destPath = getModelPath(model.id);
    final file = File(destPath);
    final tempPath = '$destPath.part';
    final tempFile = File(tempPath);

    // Initialize progress
    _downloads[model.id] = DownloadProgress(
      modelId: model.id,
      progress: 0.0,
      status: 'Starting...',
    );
    _notifyProgress();

    try {
      final client = http.Client();

      // Check for partial download and resume
      var downloaded = 0;
      if (await tempFile.exists()) {
        downloaded = await tempFile.length();
        if (downloaded >= model.sizeBytes) {
          // Partial file is complete, move to final location
          await tempFile.rename(destPath);
          _downloads[model.id] = DownloadProgress(
            modelId: model.id,
            progress: 1.0,
            isComplete: true,
            status: 'Complete',
          );
          _notifyProgress();
          return;
        }
      }

      final request = http.Request('GET', Uri.parse(model.url));
      if (downloaded > 0) {
        request.headers['Range'] = 'bytes=$downloaded-';
      }

      final response = await client.send(request);

      if (response.statusCode != 200 && response.statusCode != 206) {
        throw Exception('Download failed: ${response.statusCode}');
      }

      final contentLength =
          response.contentLength ?? (model.sizeBytes - downloaded);
      final totalBytes =
          model.sizeBytes > 0 ? model.sizeBytes : (downloaded + contentLength);

      final sink = tempFile.openWrite(mode: FileMode.append);

      await for (final chunk in response.stream) {
        sink.add(chunk);
        downloaded += chunk.length;
        final progress = totalBytes > 0 ? downloaded / totalBytes : 0.0;
        _downloads[model.id] = DownloadProgress(
          modelId: model.id,
          progress: progress.clamp(0.0, 0.99),
          bytesDownloaded: downloaded,
          totalBytes: totalBytes,
          status: 'Downloading...',
        );
        onProgress?.call(progress);
        _notifyProgress();
      }

      await sink.flush();
      await sink.close();

      // Verify SHA256 if provided
      if (model.sha256.isNotEmpty) {
        _downloads[model.id] = DownloadProgress(
          modelId: model.id,
          progress: 0.95,
          status: 'Verifying...',
        );
        _notifyProgress();

        final sha256 = await _computeSha256(tempFile);
        if (sha256.toLowerCase() != model.sha256.toLowerCase()) {
          await tempFile.delete();
          throw Exception(
            'SHA256 mismatch: expected ${model.sha256}, got $sha256',
          );
        }
      }

      // Move to final location
      if (await file.exists()) {
        await file.delete();
      }
      await tempFile.rename(destPath);

      _downloads[model.id] = DownloadProgress(
        modelId: model.id,
        progress: 1.0,
        isComplete: true,
        status: 'Complete',
      );
      _notifyProgress();
    } catch (e) {
      _downloads[model.id] = DownloadProgress(
        modelId: model.id,
        progress: 0.0,
        isComplete: false,
        error: e.toString(),
      );
      _notifyProgress();
      // Keep partial download for resume
      rethrow;
    }
  }

  Future<String> _computeSha256(File file) async {
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Get compatible models for current hardware.
  List<ModelCatalogEntry> getCompatibleModels() {
    return ModelCatalog.compatibleWith(_hardware);
  }

  void _notifyProgress() {
    _downloadProgressController.add(Map.unmodifiable(_downloads));
  }

  void dispose() {
    _downloadProgressController.close();
    SystemChannels.lifecycle.setMessageHandler(null);
  }
}

class DownloadProgress {
  final String modelId;
  final double progress;
  final bool isComplete;
  final String? error;
  final int? bytesDownloaded;
  final int? totalBytes;
  final String? status;

  const DownloadProgress({
    required this.modelId,
    this.progress = 0.0,
    this.isComplete = false,
    this.error,
    this.bytesDownloaded,
    this.totalBytes,
    this.status,
  });

  String get progressPercent => '${(progress * 100).toStringAsFixed(1)}%';

  String? get sizeInfo {
    if (bytesDownloaded == null || totalBytes == null) return null;
    final downloaded = _formatBytes(bytesDownloaded!);
    final total = _formatBytes(totalBytes!);
    return '$downloaded / $total';
  }

  static String _formatBytes(int bytes) {
    final gb = bytes / (1024 * 1024 * 1024);
    if (gb >= 1) return '${gb.toStringAsFixed(2)} GB';
    final mb = bytes / (1024 * 1024);
    return '${mb.toStringAsFixed(0)} MB';
  }
}
