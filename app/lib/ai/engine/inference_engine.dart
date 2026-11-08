/// Abstract inference engine interface.
/// Implementations: FfiInferenceEngine (native llama.cpp), or a stub for testing.
abstract class InferenceEngine {
  Future<void> init();
  Future<bool> loadModel(String path, {int threads = 4, int gpuLayers = 0});
  void unloadModel();
  bool get isLoaded;
  int get memoryMb;
  Stream<String> generate(String prompt, {int maxTokens = 512, double temperature = 0.7});
  void cancel();
}

typedef CancelToken = void;
typedef VoidCallback = void Function();