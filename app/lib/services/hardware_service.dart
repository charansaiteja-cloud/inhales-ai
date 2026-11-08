import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HardwareProfile {
  final int totalRamMb;
  final int availableRamMb;
  final int cpuCores;
  final String platform;
  final bool hasGpu;
  final int storageFreeMb;

  const HardwareProfile({
    required this.totalRamMb,
    required this.availableRamMb,
    required this.cpuCores,
    required this.platform,
    required this.hasGpu,
    required this.storageFreeMb,
  });

  bool get isLowEnd => totalRamMb <= 4096;
  bool get isMidRange => totalRamMb > 4096 && totalRamMb <= 8192;
  bool get isHighEnd => totalRamMb > 8192;
}

final hardwareServiceProvider = Provider<HardwareService>((ref) => HardwareService());

class HardwareService {
  Future<HardwareProfile> getProfile() async {
    final cores = Platform.numberOfProcessors;
    final platform = Platform.operatingSystem;
    final hasGpu = Platform.isWindows || Platform.isMacOS || Platform.isLinux;

    // Estimate RAM based on platform defaults (device_info_plus not required for stub)
    int totalRamMb;
    if (Platform.isAndroid) {
      totalRamMb = 4096;
    } else if (Platform.isIOS) {
      totalRamMb = 4096;
    } else if (Platform.isWindows) {
      totalRamMb = 8192;
    } else if (Platform.isMacOS) {
      totalRamMb = 8192;
    } else if (Platform.isLinux) {
      totalRamMb = 8192;
    } else {
      totalRamMb = 4096;
    }

    final freeMb = totalRamMb ~/ 2;

    return HardwareProfile(
      totalRamMb: totalRamMb,
      availableRamMb: freeMb,
      cpuCores: cores,
      platform: platform,
      hasGpu: hasGpu,
      storageFreeMb: 10000,
    );
  }
}