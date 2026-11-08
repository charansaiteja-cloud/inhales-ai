import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

/// Utility helpers: file paths, formatting, validation.
class PathUtils {
  static Future<String> get appDocuments async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<String> get appSupport async {
    final dir = await getApplicationSupportDirectory();
    return dir.path;
  }

  static Future<String> get appTemp async {
    final dir = await getTemporaryDirectory();
    return dir.path;
  }

  static Future<String> get appCache async {
    final dir = await getCacheDirectory();
    return dir.path;
  }

  static Future<String> modelsPath() async {
    final dir = Directory('${await appSupport}/${AppConstants.modelsDir}');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir.path;
  }

  static Future<String> documentsPath() async {
    final dir = Directory('${await appDocuments}/${AppConstants.documentsDir}');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir.path;
  }

  static Future<String> notesPath() async {
    final dir = Directory('${await appDocuments}/${AppConstants.notesDir}');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir.path;
  }
}

class FormatUtils {
  static String fileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  static String ramSize(int mb) {
    if (mb < 1024) return '$mb MB';
    return '${(mb / 1024).toStringAsFixed(1)} GB';
  }

  static String formatDuration(Duration d) {
    if (d.inMinutes > 0) {
      return '${d.inMinutes}m ${d.inSeconds % 60}s';
    }
    return '${d.inSeconds}s';
  }

  static String truncate(String s, int maxLength) {
    if (s.length <= maxLength) return s;
    return '${s.substring(0, maxLength - 3)}...';
  }
}

class ValidationUtils {
  static bool isValidModelFile(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith('.gguf');
  }

  static bool isNonEmpty(String? s) => s != null && s.trim().isNotEmpty;
}

class AppColors {
  static const Color primary = Color(0xFF559BEB);
  static const Color background = Color(0xFFEAF4FF);
}