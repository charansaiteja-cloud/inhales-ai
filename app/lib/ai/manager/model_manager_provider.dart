import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hardware_profile.dart';
import '../models/model_catalog.dart';
import '../models/model_catalog_entry.dart';

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

class DownloadProgress {
  final String modelId;
  final double progress;
  final bool isComplete;

  const DownloadProgress({required this.modelId, this.progress = 0.0, this.isComplete = false});
}

final modelManagerProvider =
    StateNotifierProvider<ModelManagerNotifier, ModelManagerState>(
  (ref) => ModelManagerNotifier(),
);

class ModelManagerNotifier extends StateNotifier<ModelManagerState> {
  ModelManagerNotifier()
      : super(const ModelManagerState(
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
            installedModels: []));

  void installModel(ModelCatalogEntry model) {
    final updated = List<ModelCatalogEntry>.from(state.installedModels)..add(model);
    state = state.copyWith(installedModels: updated);
  }

  void setActiveModel(ModelCatalogEntry model) {
    state = state.copyWith(activeModel: model);
  }
}