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
  void unloadModel();
  bool get isLoaded;
  int get memoryMb;
  int get contextLength;
  void setContext(int ctx);
  Stream<String> generate(
    String prompt, {
    int maxTokens = 512,
    double temperature = 0.7,
    double topP = 0.9,
    int topK = 40,
  });
  void cancel();
}

typedef CancelToken = void;
typedef VoidCallback = void Function();
