import 'dart:io';

/// Hardware capability profile for adaptive model selection.
class HardwareProfile {
  final int totalRamMb;
  final int availableRamMb;
  final int storageFreeMb;
  final String cpuArchitecture;
  final int cpuCores;
  final bool gpuAvailable;
  final String gpuName;
  final String os;
  final int osVersion;

  const HardwareProfile({
    required this.totalRamMb,
    required this.availableRamMb,
    required this.storageFreeMb,
    required this.cpuArchitecture,
    required this.cpuCores,
    required this.gpuAvailable,
    required this.gpuName,
    required this.os,
    required this.osVersion,
  });

  /// Performance tier: 0 = minimal, 1 = light, 2 = balanced, 3 = enhanced, 4 = advanced.
  int get performanceTier {
    if (totalRamMb >= 12288) return 4;
    if (totalRamMb >= 8192) return 3;
    if (totalRamMb >= 6144) return 2;
    if (totalRamMb >= 4096) return 1;
    return 0;
  }

  String get tierName {
    switch (performanceTier) {
      case 4:
        return 'Advanced';
      case 3:
        return 'Enhanced';
      case 2:
        return 'Balanced';
      case 1:
        return 'Light';
      default:
        return 'Minimal';
    }
  }

  bool get canRunBalanced => totalRamMb >= 4096;
  bool get canRunEnhanced => totalRamMb >= 8192;
  bool get supportsVision => totalRamMb >= 8192;
  bool get isLowMemory => totalRamMb < 4096;

  @override
  String toString() =>
      'HardwareProfile(ram=${totalRamMb}MB, cores=$cpuCores, arch=$cpuArchitecture, gpu=$gpuAvailable, tier=$tierName)';

  /// Detect the current device's hardware capabilities.
  /// Uses platform-appropriate methods: `free -m` on Linux/macOS,
  /// platform defaults on Android/iOS where `free` is unavailable.
  static Future<HardwareProfile> detect() async {
    final cores = Platform.numberOfProcessors;
    final os = Platform.operatingSystem;

    int totalRamMb = 4096;
    if (Platform.isAndroid || Platform.isIOS) {
      // On mobile, use conservative defaults — real values would require
      // device_info_plus. 4 GB is the baseline for modern Android devices.
      totalRamMb = 4096;
    } else {
      try {
        final result = await Process.run('free', ['-m']);
        if (result.exitCode == 0) {
          final lines = result.stdout.toString().trim().split('\n');
          if (lines.length > 1) {
            final parts = lines[1].trim().split(RegExp(r'\s+'));
            if (parts.length >= 2) {
              totalRamMb = int.tryParse(parts[1]) ?? 4096;
            }
          }
        }
      } catch (_) {
        // `free` not available — fall back to platform default
      }
    }

    return HardwareProfile(
      totalRamMb: totalRamMb,
      availableRamMb: (totalRamMb * 0.7).round(),
      storageFreeMb: 10000,
      cpuArchitecture: Platform.isAndroid ? 'arm64' : 'x86_64',
      cpuCores: cores,
      gpuAvailable: false,
      gpuName: 'none',
      os: os,
      osVersion: 0,
    );
  }
}
