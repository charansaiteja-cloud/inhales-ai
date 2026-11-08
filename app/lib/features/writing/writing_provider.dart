import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WritingMode {
  essay,
  letter,
  email,
  report,
  story,
  poem,
  speech,
  resume,
  article,
  social,
}

class WritingState {
  final WritingMode mode;
  final String title;
  final String content;
  final String instructions;
  final bool isGenerating;

  const WritingState({
    this.mode = WritingMode.essay,
    this.title = '',
    this.content = '',
    this.instructions = '',
    this.isGenerating = false,
  });
}

final writingProvider = StateNotifierProvider<WritingNotifier, WritingState>(
  (ref) => WritingNotifier(),
);

class WritingNotifier extends StateNotifier<WritingState> {
  WritingNotifier() : super(const WritingState());

  Future<void> setMode(WritingMode mode) async {
    state = WritingState(
      mode: mode,
      title: state.title,
      content: state.content,
      instructions: state.instructions,
      isGenerating: state.isGenerating,
    );
  }

  Future<void> setContent(String content) async {
    state = WritingState(
      mode: state.mode,
      title: state.title,
      content: content,
      instructions: state.instructions,
      isGenerating: state.isGenerating,
    );
  }

  Future<void> setInstructions(String instr) async {
    state = WritingState(
      mode: state.mode,
      title: state.title,
      content: state.content,
      instructions: instr,
      isGenerating: state.isGenerating,
    );
  }

  Future<void> generateContent() async {
    state = WritingState(
      mode: state.mode,
      title: state.title,
      content: state.content,
      instructions: state.instructions,
      isGenerating: true,
    );
    // Real implementation: prompt local AI.
    await Future.delayed(const Duration(seconds: 1));
    state = WritingState(
      mode: state.mode,
      title: state.title,
      content: state.content,
      instructions: state.instructions,
      isGenerating: false,
    );
  }
}
