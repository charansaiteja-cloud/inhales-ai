import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hardware_profile.dart';
import '../models/model_catalog_entry.dart';
import 'model_manager.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart'
    show StateNotifier, StateNotifierProvider;

/// Model manager state — tracks installed models, active model, and downloads.
class ModelManagerState {
  final HardwareProfile hardware;
  final List<ModelCatalogEntry> installedModels;
  final ModelCatalogEntry? activeModel;
  final Map<String, DownloadProgress> downloads;
  final bool isLoading;
  final String? error;

  const ModelManagerState({
    required this.hardware,
    required this.installedModels,
    this.activeModel,
    this.downloads = const {},
    this.isLoading = false,
    this.error,
  });

  ModelManagerState copyWith({
    HardwareProfile? hardware,
    List<ModelCatalogEntry>? installedModels,
    ModelCatalogEntry? activeModel,
    Map<String, DownloadProgress>? downloads,
    bool? isLoading,
    String? error,
  }) {
    return ModelManagerState(
      hardware: hardware ?? this.hardware,
      installedModels: installedModels ?? this.installedModels,
      activeModel: activeModel ?? this.activeModel,
      downloads: downloads ?? this.downloads,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final modelManagerProvider =
    StateNotifierProvider<ModelManagerNotifier, ModelManagerState>(
      (ref) => ModelManagerNotifier(),
    );

class ModelManagerNotifier extends StateNotifier<ModelManagerState> {
  ModelManager? _manager;
  StreamSubscription<Map<String, DownloadProgress>>? _downloadSub;

  ModelManagerNotifier()
    : super(
        const ModelManagerState(
          hardware: HardwareProfile(
            totalRamMb: 4096,
            availableRamMb: 2048,
            storageFreeMb: 10000,
            cpuArchitecture: 'x86_64',
            cpuCores: 4,
            gpuAvailable: false,
            gpuName: 'none',
            os: 'linux',
            osVersion: 1,
          ),
          installedModels: [],
        ),
      ) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final manager = await ModelManager.create();
      _manager = manager;
      state = state.copyWith(hardware: manager.hardware, isLoading: false);
      _downloadSub = manager.downloadsStream.listen(_onDownloadProgress);
      manager.setOnMemoryPressure(() {
        // Unload model on memory pressure to free RAM
        if (state.activeModel != null) {
          _unloadActiveModel();
        }
      });
      await _refreshInstalled();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _unloadActiveModel() {
    state = state.copyWith(activeModel: null);
  }

  void _onDownloadProgress(Map<String, DownloadProgress> progress) {
    state = state.copyWith(downloads: progress);
  }

  Future<void> _refreshInstalled() async {
    if (_manager == null) return;
    final installed = await _manager!.getInstalledModels();
    state = state.copyWith(installedModels: installed);
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    try {
      if (_manager == null) {
        _manager = await ModelManager.create();
        state = state.copyWith(hardware: _manager!.hardware);
      }
      _downloadSub?.cancel();
      _downloadSub = _manager!.downloadsStream.listen(_onDownloadProgress);
      await _refreshInstalled();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> installModel(ModelCatalogEntry model) async {
    if (_manager == null) return;
    state = state.copyWith(isLoading: true);
    try {
      await _manager!.downloadModel(
        model,
        onProgress: (progress) {
          state = state.copyWith(
            downloads: {
              ...state.downloads,
              model.id: DownloadProgress(
                modelId: model.id,
                progress: progress,
                isComplete: false,
              ),
            },
          );
        },
      );
      state = state.copyWith(
        downloads: {
          ...state.downloads,
          model.id: const DownloadProgress(
            modelId: '',
            progress: 1.0,
            isComplete: true,
          ),
        },
      );
      await _refreshInstalled();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
    state = state.copyWith(isLoading: false);
  }

  void setActiveModel(ModelCatalogEntry? model) {
    state = state.copyWith(activeModel: model);
  }

  Future<void> deleteModel(String modelId) async {
    if (_manager == null) return;
    try {
      await _manager!.deleteModel(modelId);
      await _refreshInstalled();
      if (state.activeModel?.id == modelId) {
        state = state.copyWith(
          activeModel:
              state.installedModels.isNotEmpty
                  ? state.installedModels.first
                  : null,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void updateDownloadProgress(
    String modelId,
    double progress, {
    bool isComplete = false,
  }) {
    final downloads = Map<String, DownloadProgress>.from(state.downloads);
    downloads[modelId] = DownloadProgress(
      modelId: modelId,
      progress: progress,
      isComplete: isComplete,
    );
    state = state.copyWith(downloads: downloads);
  }

  @override
  void dispose() {
    _downloadSub?.cancel();
    _manager?.dispose();
    super.dispose();
  }
}
