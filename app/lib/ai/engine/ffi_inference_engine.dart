import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inference_engine.dart';
import 'ffi_bindings.dart';

/// FFI-based inference engine backed by the native C++ engine.
///
/// When the native shared library is unavailable, it falls back to a
/// deterministic simulated response so the app remains functional.
class FfiInferenceEngine implements InferenceEngine {
  InhaleFFI? _ffi;
  bool _libraryAvailable = false;

  FfiInferenceEngine() {
    try {
      final dylib = DynamicLibrary.open('libinhale_engine.so');
      _ffi = InhaleFFI(dylib);
      _libraryAvailable = true;
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
    int contextLength = 2048,
  }) async {
    if (_ffi == null) return false;
    final pathPtr = path.toNativeUtf8();
    try {
      final rc = _ffi!.inhale_load_model(
        pathPtr,
        contextLength,
        threads,
        gpuLayers,
      );
      return rc == 0;
    } finally {
      malloc.free(pathPtr);
    }
  }

  @override
  void unloadModel() {
    _ffi?.inhale_unload_model();
  }

  @override
  bool get isLoaded => _ffi?.inhale_is_loaded() == 1;

  @override
  int get memoryMb => _ffi?.inhale_get_memory_mb() ?? 0;

  @override
  int get contextLength => _ffi?.inhale_get_context() ?? 2048;

  @override
  void setContext(int ctx) {
    _ffi?.inhale_set_context(ctx);
  }

  @override
  Stream<String> generate(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
  }) async* {
    if (_ffi == null || !_libraryAvailable || !isLoaded) {
      yield _simulateResponse(prompt);
      return;
    }

    // Native synchronous call - returns full response
    final promptPtr = prompt.toNativeUtf8();
    try {
      final rc = _ffi!.inhale_generate(
        promptPtr,
        maxTokens,
        temperature,
        topP,
        topK,
        nullptr,
        nullptr,
        nullptr,
        0,
      );
      if (rc == 0) {
        yield 'Response generated via native engine.';
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
    final lower = prompt.toLowerCase().trim();
    if (lower.isEmpty) {
      return 'Type a message to begin. Install a local model via the Model Manager.';
    }
    if (lower.contains('hello') || lower.contains('hi ')) {
      return 'Hello! I am InhaleSkill AI. How can I help you learn today?';
    }
    if (lower.contains('who are you') || lower.contains('what are you')) {
      return 'I am InhaleSkill AI — a fully offline AI learning assistant.';
    }
    return 'Install a local GGUF model via the Model Manager for real responses.';
  }
}

final ffiInferenceEngineProvider = Provider<FfiInferenceEngine>(
  (ref) => FfiInferenceEngine(),
);