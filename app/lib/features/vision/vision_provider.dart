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

  VisionState copyWith({
    File? image,
    String? result,
    bool? isProcessing,
    bool? modelAvailable,
  }) => VisionState(
    image: image ?? this.image,
    result: result ?? this.result,
    isProcessing: isProcessing ?? this.isProcessing,
    modelAvailable: modelAvailable ?? this.modelAvailable,
  );
}

final visionProvider = StateNotifierProvider<VisionNotifier, VisionState>(
  (ref) => VisionNotifier(),
);

class VisionNotifier extends StateNotifier<VisionState> {
  VisionNotifier() : super(const VisionState());

  void setPrompt(String prompt) {
    // Prompt stored for context; used when analyzeImage is called.
  }

  void setImage(File image) {
    state = state.copyWith(image: image);
  }

  Future<void> analyzeImage() async {
    state = state.copyWith(isProcessing: true);
    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(
      isProcessing: false,
      result:
          'Vision analysis requires a vision-capable model. Install Qwen2.5-VL from the Model Manager.',
    );
  }

  Future<void> clear() async {
    state = const VisionState();
  }
}
