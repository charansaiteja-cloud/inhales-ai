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

  WritingState copyWith({
    WritingMode? mode,
    String? title,
    String? content,
    String? instructions,
    bool? isGenerating,
  }) =>
      WritingState(
        mode: mode ?? this.mode,
        title: title ?? this.title,
        content: content ?? this.content,
        instructions: instructions ?? this.instructions,
        isGenerating: isGenerating ?? this.isGenerating,
      );
}

final writingProvider = StateNotifierProvider<WritingNotifier, WritingState>(
  (ref) => WritingNotifier(),
);

class WritingNotifier extends StateNotifier<WritingState> {
  WritingNotifier() : super(const WritingState());

  void setMode(WritingMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setInstructions(String instr) {
    state = state.copyWith(instructions: instr);
  }

  Future<void> generateContent() async {
    state = state.copyWith(isGenerating: true);
    // Real implementation: prompt local AI.
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isGenerating: false);
  }
}
