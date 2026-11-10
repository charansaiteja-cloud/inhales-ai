import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../../ai/engine/ai_engine.dart';

class CodingState {
  final String code;
  final String language;
  final String output;
  final bool isExecuting;
  final List<String> suggestions;
  final String? error;

  const CodingState({
    this.code = '',
    this.language = 'python',
    this.output = '',
    this.isExecuting = false,
    this.suggestions = const [],
    this.error,
  });
}

final codingProvider = StateNotifierProvider<CodingNotifier, CodingState>(
  (ref) => CodingNotifier(ref.watch(aiEngineProvider)),
);

class CodingNotifier extends StateNotifier<CodingState> {
  final AIEngine _aiEngine;

  CodingNotifier(this._aiEngine) : super(const CodingState());

  Future<void> setCode(String code) async {
    state = state.copyWith(code: code);
  }

  Future<void> setLanguage(String lang) async {
    state = state.copyWith(language: lang);
  }

  Future<void> askAI(String prompt) async {
    if (prompt.trim().isEmpty) return;
    state = state.copyWith(isExecuting: true, error: null);

    try {
      final systemPrompt = _buildSystemPrompt();
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [
          ChatMessage(
            role: 'system',
            content: systemPrompt,
            timestamp: DateTime.now(),
          ),
        ],
        maxTokens: 1024,
        temperature: 0.3,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      state = state.copyWith(output: buffer.toString(), isExecuting: false);
    } catch (e) {
      state = state.copyWith(isExecuting: false, error: e.toString());
    }
  }

  String _buildSystemPrompt() {
    return 'You are a coding assistant. Write clean, well-commented ${state.language} code. '
        'Provide explanations when asked. Output code blocks with language tags.';
  }
}

extension on CodingState {
  CodingState copyWith({
    String? code,
    String? language,
    String? output,
    bool? isExecuting,
    List<String>? suggestions,
    String? error,
  }) => CodingState(
    code: code ?? this.code,
    language: language ?? this.language,
    output: output ?? this.output,
    isExecuting: isExecuting ?? this.isExecuting,
    suggestions: suggestions ?? this.suggestions,
    error: error ?? this.error,
  );
}
