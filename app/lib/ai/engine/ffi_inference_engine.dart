import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inference_engine.dart';
import 'ffi_bindings.dart';
import 'ffi_callback_bridge.dart';

/// FFI-based inference engine backed by the native C++ engine.
class FfiInferenceEngine implements InferenceEngine {
  InhaleFFI? _ffi;
  bool _libraryAvailable = false;
  bool _isGenerating = false;
  Completer<void>? _cancelCompleter;

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
  Future<bool> loadEmbeddingModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
  }) async {
    if (_ffi == null) return false;
    final pathPtr = path.toNativeUtf8();
    try {
      final rc = _ffi!.inhale_load_embedding_model(pathPtr, threads, gpuLayers);
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
  void unloadEmbeddingModel() {
    _ffi?.inhale_unload_embedding_model();
  }

  @override
  bool get isLoaded => _ffi?.inhale_is_loaded() == 1;

  @override
  bool get isEmbeddingLoaded => _ffi?.inhale_is_embedding_loaded() == 1;

  @override
  int get memoryMb => _ffi?.inhale_get_memory_mb() ?? 0;

  @override
  int get contextLength => _ffi?.inhale_get_context() ?? 2048;

  @override
  int get embeddingDim => _ffi?.inhale_get_embedding_dim() ?? 0;

  @override
  void setContext(int ctx) {
    _ffi?.inhale_set_context(ctx);
  }

  @override
  Stream<String> generate(
    String prompt, {
    String? systemPrompt,
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
  }) async* {
    if (_ffi == null || !_libraryAvailable || !isLoaded) {
      yield* _simulateStream(prompt, systemPrompt);
      return;
    }

    if (_isGenerating) {
      yield 'Previous generation still in progress.';
      return;
    }

    _isGenerating = true;
    _cancelCompleter = Completer<void>();

    final bridge = CallbackBridge();
    final promptPtr = prompt.toNativeUtf8();
    final systemPtr =
        systemPrompt != null && systemPrompt.isNotEmpty
            ? systemPrompt.toNativeUtf8()
            : nullptr;

    try {
      final rc = _ffi!.inhale_generate(
        promptPtr,
        maxTokens,
        temperature,
        topP,
        topK,
        bridge.tokenPtr,
        bridge.donePtr,
        bridge.errorPtr,
        0,
      );

      if (rc == 0) {
        await bridge.waitForDone();
        if (bridge.error != null) {
          yield 'Error: ${bridge.error}';
        } else {
          await for (final token in bridge.tokenStream()) {
            if (_cancelCompleter!.isCompleted) {
              yield ' [Generation stopped]';
              return;
            }
            await Future.delayed(const Duration(milliseconds: 20));
            yield token;
          }
        }
      } else {
        yield* _simulateStream(prompt, systemPrompt);
      }
    } catch (_) {
      yield* _simulateStream(prompt, systemPrompt);
    } finally {
      malloc.free(promptPtr);
      if (systemPtr != nullptr) {
        malloc.free(systemPtr);
      }
      bridge.dispose();
      _isGenerating = false;
      if (_cancelCompleter != null && !_cancelCompleter!.isCompleted) {
        _cancelCompleter!.complete();
      }
    }
  }

  @override
  void cancel() {
    if (_cancelCompleter != null && !_cancelCompleter!.isCompleted) {
      _cancelCompleter!.complete();
    }
    _ffi?.inhale_cancel();
    _isGenerating = false;
  }

  @override
  Future<List<double>?> generateEmbedding(String text) async {
    if (_ffi == null || !_libraryAvailable || !isEmbeddingLoaded) {
      return null;
    }
    final bridge = EmbeddingCallbackBridge();
    final textPtr = text.toNativeUtf8();
    try {
      final rc = _ffi!.inhale_generate_embedding(
        textPtr,
        bridge.embeddingPtr,
        bridge.errorPtr,
      );
      if (rc != 0) {
        return null;
      }
      return await bridge.waitForEmbedding();
    } finally {
      malloc.free(textPtr);
      bridge.dispose();
    }
  }

  Stream<String> _simulateStream(String prompt, String? systemPrompt) async* {
    final response = _simulateResponse(prompt, systemPrompt);
    final words = response.split(RegExp(r'\s+'));

    for (var i = 0; i < words.length; i++) {
      if (_cancelCompleter != null && _cancelCompleter!.isCompleted) {
        yield ' [Generation stopped]';
        return;
      }
      await Future.delayed(const Duration(milliseconds: 30));
      yield (i == 0) ? words[i] : ' ${words[i]}';
    }
  }

  String _simulateResponse(String prompt, String? systemPrompt) {
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
    if (lower.contains('help')) {
      return '''I can help you with:
• Learning new topics
• Solving math problems
• Writing and coding assistance
• Document analysis
• Quiz generation
• Study planning

Install a GGUF model for full capabilities.''';
    }
    return 'Install a local GGUF model via the Model Manager for real responses. Currently running in simulation mode.';
  }

  /// Release resources.
  Future<void> dispose() async {
    cancel();
    unloadModel();
    _ffi = null;
    _libraryAvailable = false;
  }
}

final ffiInferenceEngineProvider = Provider<FfiInferenceEngine>(
  (ref) => FfiInferenceEngine(),
);
