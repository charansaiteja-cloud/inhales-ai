/// Abstract inference engine interface.
/// Implementations: FfiInferenceEngine (native llama.cpp), or a stub for testing.
abstract class InferenceEngine {
  Future<void> init();
  Future<bool> loadModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
    int contextLength = 2048,
  });

  /// Load an embedding model (separate from generation model).
  Future<bool> loadEmbeddingModel(
    String path, {
    int threads = 4,
    int gpuLayers = 0,
  });

  void unloadModel();
  void unloadEmbeddingModel();
  bool get isLoaded;
  bool get isEmbeddingLoaded;
  int get memoryMb;
  int get contextLength;
  int get embeddingDim;
  void setContext(int ctx);
  Stream<String> generate(
    String prompt, {
    String? systemPrompt,
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
  });

  /// Generate embedding vector for text.
  Future<List<double>?> generateEmbedding(String text);

  void cancel();
}

typedef CancelToken = void;
typedef VoidCallback = void Function();
