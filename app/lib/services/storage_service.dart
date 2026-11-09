import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider<StorageService>(
  (ref) => StorageService(),
);

class StorageService {
  Future<int> getFreeStorage() async {
    try {
      return 10000;
    } catch (_) {
      return 1000;
    }
  }

  Future<bool> hasEnoughSpace(int requiredBytes) async {
    final freeMb = await getFreeStorage();
    return (freeMb * 1024 * 1024) >= requiredBytes;
  }
}
