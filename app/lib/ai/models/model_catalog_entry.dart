import 'hardware_profile.dart';

/// Model catalogue entry — describes an available local AI model.
class ModelCatalogEntry {
  final String id;
  final String name;
  final String description;
  final String url;
  final int sizeBytes;
  final String quantization;
  final List<String> supportedTasks;
  final int minRamMb;
  final int recommendedRamMb;
  final String license;
  final String architecture;
  final String sha256;
  final bool vision;
  final String family;

  const ModelCatalogEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.sizeBytes,
    required this.quantization,
    required this.supportedTasks,
    required this.minRamMb,
    required this.recommendedRamMb,
    required this.license,
    required this.architecture,
    this.sha256 = '',
    this.vision = false,
    this.family = 'generic',
  });

  String get sizeLabel {
    final gb = sizeBytes / (1024 * 1024 * 1024);
    if (gb >= 1) return '${gb.toStringAsFixed(2)} GB';
    final mb = sizeBytes / (1024 * 1024);
    return '${mb.toStringAsFixed(0)} MB';
  }

  String get ramTier {
    if (minRamMb <= 4096) return '4 GB';
    if (minRamMb <= 6144) return '6 GB';
    if (minRamMb <= 8192) return '8 GB';
    if (minRamMb <= 12288) return '12 GB';
    return '16 GB+';
  }

  String get provider => family;

  bool get isCompatibleWithMin => true;

  bool compatibleWith(HardwareProfile hw) {
    return hw.totalRamMb >= minRamMb;
  }
}
