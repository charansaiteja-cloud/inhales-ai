import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../../di/di.dart';
import '../../ai/engine/ai_engine.dart';

class VisionState {
  final File? image;
  final String? result;
  final bool isProcessing;
  final String prompt;
  final String? error;

  const VisionState({
    this.image,
    this.result,
    this.isProcessing = false,
    this.prompt = '',
    this.error,
  });

  VisionState copyWith({
    File? image,
    String? result,
    bool? isProcessing,
    String? prompt,
    String? error,
  }) => VisionState(
    image: image ?? this.image,
    result: result ?? this.result,
    isProcessing: isProcessing ?? this.isProcessing,
    prompt: prompt ?? this.prompt,
    error: error ?? this.error,
  );
}

final visionProvider = StateNotifierProvider<VisionNotifier, VisionState>(
  (ref) => VisionNotifier(ref.watch(aiEngineProvider)),
);

class VisionNotifier extends StateNotifier<VisionState> {
  VisionNotifier(AIEngine aiEngine) : super(const VisionState());

  void setPrompt(String prompt) {
    state = state.copyWith(prompt: prompt);
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null || result.files.isEmpty) return;

    final file = File(result.files.first.path!);
    state = state.copyWith(image: file);
  }

  Future<void> analyzeImage() async {
    if (state.image == null) {
      state = state.copyWith(error: 'No image selected');
      return;
    }

    state = state.copyWith(isProcessing: true, error: null);

    // Vision requires a multimodal model - not yet supported
    state = state.copyWith(
      isProcessing: false,
      result:
          'Vision analysis requires a multimodal model (Qwen2.5-VL, LLaVA). '
          'Install a vision-capable GGUF model and implement vision inference in FfiInferenceEngine.',
    );
  }

  Future<void> clear() async {
    state = const VisionState();
  }
}
