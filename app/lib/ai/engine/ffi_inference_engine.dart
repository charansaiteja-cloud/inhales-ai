import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inference_engine.dart';
import 'ffi_bindings.dart';

/// FFI-based inference engine backed by the native C++ stub.
/// When USE_LLAMA=ON and llama.cpp is cloned into native/llama.cpp, this
/// engine will call the real llama.cpp runtime. Until then, it falls back
/// to simulated responses so the app remains functional.
class FfiInferenceEngine implements InferenceEngine {
  InhaleFFI? _ffi;

  FfiInferenceEngine() {
    try {
      final dylib = DynamicLibrary.open('libinhale_engine.so');
      _ffi = InhaleFFI(dylib);
    } catch (_) {
      _ffi = null;
    }
  }

  @override
  Future<void> init() async {
    _ffi?.inhale_init();
  }

  @override
  Future<bool> loadModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
  }) async {
    if (_ffi == null) return false;
    final pathPtr = path.toNativeUtf8();
    final threadsPtr = threads.toString().toNativeUtf8();
    final layersPtr = gpuLayers.toString().toNativeUtf8();
    try {
      _ffi!.inhale_load_model(pathPtr, threadsPtr, layersPtr);
      return true;
    } finally {
      malloc.free(pathPtr);
      malloc.free(threadsPtr);
      malloc.free(layersPtr);
    }
  }

  @override
  void unloadModel() {
    _ffi?.inhale_unload_model();
  }

  @override
  bool get isLoaded => _ffi?.inhale_is_loaded() ?? false;

  @override
  int get memoryMb => _ffi?.inhale_get_memory_mb() ?? 0;

  @override
  Stream<String> generate(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
  }) async* {
    if (_ffi == null) {
      yield _simulateResponse(prompt);
      return;
    }
    final promptPtr = prompt.toNativeUtf8();
    try {
      final resultPtr = _ffi!.inhale_generate(promptPtr, nullptr);
      if (resultPtr != nullptr) {
        yield resultPtr.toDartString();
      } else {
        yield _simulateResponse(prompt);
      }
    } finally {
      malloc.free(promptPtr);
    }
  }

  @override
  void cancel() {
    _ffi?.inhale_cancel();
  }

  String _simulateResponse(String prompt) {
    final lower = prompt.toLowerCase();
    if (lower.contains('hello') || lower.contains('hi')) {
      return 'Hello! I am InhaleSkill AI. How can I help you learn today?';
    }
    if (lower.contains('who') || lower.contains('what')) {
      return 'I am InhaleSkill AI — a fully offline AI learning assistant. Ask me anything!';
    }
    return 'I received your request: "${prompt.length > 60 ? prompt.substring(0, 60) + '...' : prompt}". Install a local model via the Model Manager for full responses.';
  }
}

final ffiInferenceEngineProvider = Provider<FfiInferenceEngine>(
  (ref) => FfiInferenceEngine(),
);
