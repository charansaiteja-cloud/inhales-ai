import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodingState {
  final String code;
  final String language;
  final String output;
  final bool isExecuting;
  final List<String> suggestions;

  const CodingState({
    this.code = '',
    this.language = 'python',
    this.output = '',
    this.isExecuting = false,
    this.suggestions = const [],
  });
}

final codingProvider = StateNotifierProvider<CodingNotifier, CodingState>(
  (ref) => CodingNotifier(),
);

class CodingNotifier extends StateNotifier<CodingState> {
  CodingNotifier() : super(const CodingState());

  Future<void> setCode(String code) async {
    state = CodingState(
      code: code,
      language: state.language,
      output: state.output,
      isExecuting: state.isExecuting,
      suggestions: state.suggestions,
    );
  }

  Future<void> setLanguage(String lang) async {
    state = CodingState(
      code: state.code,
      language: lang,
      output: state.output,
      isExecuting: state.isExecuting,
      suggestions: state.suggestions,
    );
  }

  Future<void> askAI(String prompt) async {
    // Real implementation: prompt local AI for code generation/explanation.
    final response =
        'AI response requires a language model. Install one from the Model Manager.';
    state = CodingState(
      code: state.code,
      language: state.language,
      output: response,
      isExecuting: false,
      suggestions: state.suggestions,
    );
  }
}
