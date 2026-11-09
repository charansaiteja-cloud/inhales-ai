import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ai/models/hardware_profile.dart';

final hardwareServiceProvider = Provider<HardwareService>(
  (ref) => HardwareService(),
);

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
      storageFreeMb: 10000,
      cpuArchitecture: Platform.isAndroid ? 'arm64' : 'x64',
      cpuCores: cores,
      gpuAvailable: hasGpu,
      gpuName: hasGpu ? 'Integrated/Discrete' : 'None',
      os: platform,
      osVersion: 0,
    );
  }
}
