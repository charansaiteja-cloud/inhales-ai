import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Monitors network connectivity and enforces offline mode.
class OfflineService {
  static final _instance = OfflineService._();
  factory OfflineService() => _instance;
  OfflineService._() {
    _connectivity.onConnectivityChanged.listen(_updateState);
  }

  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();
  bool _isOnline = true;

  Stream<bool> get connectivityChanges => _controller.stream;
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  void _updateState(List<ConnectivityResult> result) {
    _isOnline = !result.contains(ConnectivityResult.none);
    _controller.add(_isOnline);
  }

  bool canAccessInternet(bool offlineMode) {
    return !offlineMode && _isOnline;
  }

  void dispose() {
    _controller.close();
  }
}
