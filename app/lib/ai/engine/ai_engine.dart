/// AI Engine abstraction for local LLM inference.
/// Supports multiple backends: FFI (llama.cpp), ONNX, or stub.
library;

import 'dart:async';

/// High-level AI Engine interface.
abstract class AIEngine {
  /// Initialize the engine.
  Future<void> initialize();

  /// Load a model by path.
  Future<bool> loadModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
    int contextLength = 2048,
  });

  /// Unload current model.
  void unloadModel();

  /// Check if a model is loaded.
  bool get isLoaded;

  /// Current model memory usage in MB.
  int get memoryMb;

  /// Current context length.
  int get contextLength;

  /// Generate completion stream.
  Stream<String> generate({
    required String prompt,
    required List<ChatMessage> history,
    String? systemPrompt,
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
    Map<String, dynamic>? options,
  });

  /// Cancel ongoing generation.
  void cancel();

  /// Release resources.
  Future<void> dispose();
}

/// Chat message for context.
class ChatMessage {
  final String role; // 'user', 'assistant', 'system'
  final String content;
  final DateTime timestamp;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };
}
