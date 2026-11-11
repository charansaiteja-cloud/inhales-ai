import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ai/models/hardware_profile.dart';

final hardwareServiceProvider = Provider<HardwareService>(
  (ref) => HardwareService(),
);

/// Central service for hardware detection.
/// Delegates to [HardwareProfile.detect()] as the single source of truth.
class HardwareService {
  HardwareProfile? _cachedProfile;

  /// Get hardware profile, using cached value if available.
  Future<HardwareProfile> getProfile({bool refresh = false}) async {
    if (!refresh && _cachedProfile != null) {
      return _cachedProfile!;
    }
    _cachedProfile = await HardwareProfile.detect();
    return _cachedProfile!;
  }

  /// Clear cached profile (e.g. after device changes).
  void clearCache() {
    _cachedProfile = null;
  }
}
