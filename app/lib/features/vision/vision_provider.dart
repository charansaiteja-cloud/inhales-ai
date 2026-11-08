import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VisionState {
  final File? image;
  final String? result;
  final bool isProcessing;
  final bool modelAvailable;

  const VisionState({
    this.image,
    this.result,
    this.isProcessing = false,
    this.modelAvailable = false,
  });
}

final visionProvider = StateNotifierProvider<VisionNotifier, VisionState>(
  (ref) => VisionNotifier(),
);

class VisionNotifier extends StateNotifier<VisionState> {
  String _prompt = '';

  VisionNotifier() : super(const VisionState());

  void setPrompt(String prompt) {
    _prompt = prompt;
  }

  Future<void> setImage(File image) async {
    state = VisionState(
      image: image,
      result: state.result,
      isProcessing: false,
      modelAvailable: state.modelAvailable,
    );
  }

  Future<void> analyzeImage() async {
    state = VisionState(
      image: state.image,
      result: '',
      isProcessing: true,
      modelAvailable: state.modelAvailable,
    );
    await Future.delayed(const Duration(seconds: 2));
    state = VisionState(
      image: state.image,
      result: 'Vision analysis requires a vision model. Install Qwen2.5-VL from Model Manager.',
      isProcessing: false,
      modelAvailable: false,
    );
  }

  Future<void> clear() async {
    state = const VisionState();
  }
}
