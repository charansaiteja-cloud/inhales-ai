import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../../ai/engine/ai_engine.dart';

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
  final String? error;

  const WritingState({
    this.mode = WritingMode.essay,
    this.title = '',
    this.content = '',
    this.instructions = '',
    this.isGenerating = false,
    this.error,
  });

  WritingState copyWith({
    WritingMode? mode,
    String? title,
    String? content,
    String? instructions,
    bool? isGenerating,
    String? error,
  }) =>
      WritingState(
        mode: mode ?? this.mode,
        title: title ?? this.title,
        content: content ?? this.content,
        instructions: instructions ?? this.instructions,
        isGenerating: isGenerating ?? this.isGenerating,
        error: error ?? this.error,
      );
}

final writingProvider = StateNotifierProvider<WritingNotifier, WritingState>(
  (ref) => WritingNotifier(ref.watch(aiEngineProvider)),
);

class WritingNotifier extends StateNotifier<WritingState> {
  final AIEngine _aiEngine;

  WritingNotifier(this._aiEngine) : super(const WritingState());

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
    if (state.title.isEmpty && state.instructions.isEmpty) {
      state = state.copyWith(error: 'Provide a title or instructions');
      return;
    }

    state = state.copyWith(isGenerating: true, error: null);

    try {
      final prompt = _buildPrompt();
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 1024,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
        state = state.copyWith(content: buffer.toString());
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isGenerating: false);
    }

    state = state.copyWith(isGenerating: false);
  }

  String _buildPrompt() {
    final modeInstructions = switch (state.mode) {
      WritingMode.essay =>
        'Write a well-structured essay with introduction, body paragraphs, and conclusion.',
      WritingMode.letter =>
        'Write a professional letter with proper formatting.',
      WritingMode.email => 'Write a clear, concise email.',
      WritingMode.report =>
        'Write a formal report with executive summary, findings, and recommendations.',
      WritingMode.story =>
        'Write an engaging short story with characters, plot, and setting.',
      WritingMode.poem =>
        'Write a poem with appropriate structure and imagery.',
      WritingMode.speech =>
        'Write a compelling speech with opening, body, and closing.',
      WritingMode.resume => 'Write a professional resume summary.',
      WritingMode.article =>
        'Write an informative article with headings and subheadings.',
      WritingMode.social => 'Write an engaging social media post.',
    };

    final buffer = StringBuffer();
    buffer.writeln('<<SYS>>');
    buffer.writeln('You are a writing assistant. $modeInstructions');
    if (state.instructions.isNotEmpty) {
      buffer.writeln('Additional instructions: ${state.instructions}');
    }
    buffer.writeln('<</SYS>>');
    buffer.writeln();
    buffer.writeln('<<USER>>');
    buffer.writeln(
      state.title.isNotEmpty
          ? state.title
          : 'Write content for the given topic.',
    );
    buffer.writeln('</USER>>');
    buffer.writeln('<<ASSISTANT>>');

    return buffer.toString();
  }
}
