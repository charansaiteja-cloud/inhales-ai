/// AI Engine implementation backed by FFI inference engine.
library;

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ai_engine.dart';
import 'inference_engine.dart';
import 'ffi_inference_engine.dart';

/// Adapter that wraps the low-level InferenceEngine into the high-level AIEngine.
class FfiAIEngine implements AIEngine {
  final InferenceEngine _engine;

  FfiAIEngine({InferenceEngine? engine})
    : _engine = engine ?? FfiInferenceEngine();

  @override
  Future<void> initialize() async {
    await _engine.init();
  }

  @override
  Future<bool> loadModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
    int contextLength = 2048,
  }) async {
    return await _engine.loadModel(
      path,
      threads: threads,
      gpuLayers: gpuLayers,
      contextLength: contextLength,
    );
  }

  @override
  Future<bool> loadEmbeddingModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
  }) async {
    return await _engine.loadEmbeddingModel(
      path,
      threads: threads,
      gpuLayers: gpuLayers,
    );
  }

  @override
  void unloadModel() {
    _engine.unloadModel();
  }

  @override
  void unloadEmbeddingModel() {
    _engine.unloadEmbeddingModel();
  }

  @override
  bool get isLoaded => _engine.isLoaded;

  @override
  bool get isEmbeddingLoaded => _engine.isEmbeddingLoaded;

  @override
  int get memoryMb => _engine.memoryMb;

  @override
  int get contextLength => _engine.contextLength;

  @override
  int get embeddingDim => _engine.embeddingDim;

  @override
  Stream<String> generate({
    required String prompt,
    required List<ChatMessage> history,
    String? systemPrompt,
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
    Map<String, dynamic>? options,
  }) async* {
    // Build prompt with history and system prompt
    final fullPrompt = _buildPrompt(history, prompt, systemPrompt);

    yield* _engine.generate(
      fullPrompt,
      maxTokens: maxTokens,
      temperature: temperature,
      topP: topP,
      topK: topK,
    );
  }

  @override
  Future<List<double>?> generateEmbedding(String text) async {
    return await _engine.generateEmbedding(text);
  }

  @override
  void cancel() {
    _engine.cancel();
  }

  @override
  Future<void> dispose() async {
    _engine.unloadModel();
  }

  String _buildPrompt(
    List<ChatMessage> history,
    String currentPrompt,
    String? systemPrompt,
  ) {
    final buffer = StringBuffer();

    // System prompt
    buffer.writeln('<<SYS>>');
    if (systemPrompt != null && systemPrompt.isNotEmpty) {
      buffer.writeln(systemPrompt);
    } else {
      buffer.writeln(
        'You are InhaleSkill AI, a helpful offline learning assistant.',
      );
      buffer.writeln('Provide clear, accurate, and educational responses.');
    }
    buffer.writeln('<</SYS>>');
    buffer.writeln();

    // History
    for (final msg in history) {
      if (msg.role == 'user') {
        buffer.writeln('<<USER>>');
        buffer.writeln(msg.content);
        buffer.writeln('</USER>>');
      } else if (msg.role == 'assistant') {
        buffer.writeln('<<ASSISTANT>>');
        buffer.writeln(msg.content);
        buffer.writeln('</ASSISTANT>>');
      }
    }

    // Current prompt
    buffer.writeln('<<USER>>');
    buffer.writeln(currentPrompt);
    buffer.writeln('</USER>>');
    buffer.writeln('<<ASSISTANT>>');

    return buffer.toString();
  }
}

/// Provider for the AI Engine.
final aiEngineProvider = Provider<AIEngine>((ref) {
  final engine = FfiAIEngine();
  ref.onDispose(() => engine.dispose());
  return engine;
});
