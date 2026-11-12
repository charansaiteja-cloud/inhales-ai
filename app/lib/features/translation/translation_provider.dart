import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../../ai/engine/ai_engine.dart';

class TranslationState {
  final String sourceText;
  final String translatedText;
  final String inputText;
  final String sourceLang;
  final String targetLang;
  final bool isTranslating;
  final List<TranslationHistory> history;
  final String? error;

  const TranslationState({
    this.sourceText = '',
    this.translatedText = '',
    this.inputText = '',
    this.sourceLang = 'en',
    this.targetLang = 'hi',
    this.isTranslating = false,
    this.history = const [],
    this.error,
  });
}

class TranslationHistory {
  final String source;
  final String translated;
  final String sourceLang;
  final String targetLang;
  final DateTime timestamp;

  const TranslationHistory({
    required this.source,
    required this.translated,
    required this.sourceLang,
    required this.targetLang,
    required this.timestamp,
  });
}

final translationProvider =
    StateNotifierProvider<TranslationNotifier, TranslationState>(
  (ref) => TranslationNotifier(ref.watch(aiEngineProvider)),
);

class TranslationNotifier extends StateNotifier<TranslationState> {
  final AIEngine _aiEngine;

  TranslationNotifier(this._aiEngine) : super(const TranslationState());

  Future<void> translate(String text) async {
    if (text.trim().isEmpty) return;
    state = state.copyWith(sourceText: text, isTranslating: true, error: null);

    try {
      final prompt = _buildPrompt(text);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 512,
        temperature: 0.3,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final result = buffer.toString().trim();

      final historyEntry = TranslationHistory(
        source: text,
        translated: result,
        sourceLang: state.sourceLang,
        targetLang: state.targetLang,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        sourceText: text,
        translatedText: result,
        isTranslating: false,
        history: [historyEntry, ...state.history],
      );
    } catch (e) {
      state = state.copyWith(isTranslating: false, error: e.toString());
    }
  }

  Future<void> swapLanguages() async {
    state = state.copyWith(
      sourceText: state.translatedText,
      translatedText: state.sourceText,
      sourceLang: state.targetLang,
      targetLang: state.sourceLang,
    );
  }

  Future<void> setLanguages(String src, String tgt) async {
    state = state.copyWith(sourceLang: src, targetLang: tgt);
  }

  Future<void> setInputText(String text) async {
    state = state.copyWith(inputText: text);
  }

  String _buildPrompt(String text) {
    return '''
<<SYS>>
You are a translator. Translate the following text from ${_langName(state.sourceLang)} to ${_langName(state.targetLang)}. Output only the translation, no explanations.
<</SYS>>

<<USER>>
$text
</USER>>

<<ASSISTANT>>
''';
  }

  String _langName(String code) {
    const names = {
      'en': 'English',
      'hi': 'Hindi',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'zh': 'Chinese',
      'ja': 'Japanese',
      'ko': 'Korean',
      'ar': 'Arabic',
      'ru': 'Russian',
    };
    return names[code] ?? code;
  }
}

extension on TranslationState {
  TranslationState copyWith({
    String? sourceText,
    String? translatedText,
    String? inputText,
    String? sourceLang,
    String? targetLang,
    bool? isTranslating,
    List<TranslationHistory>? history,
    String? error,
  }) =>
      TranslationState(
        sourceText: sourceText ?? this.sourceText,
        translatedText: translatedText ?? this.translatedText,
        inputText: inputText ?? this.inputText,
        sourceLang: sourceLang ?? this.sourceLang,
        targetLang: targetLang ?? this.targetLang,
        isTranslating: isTranslating ?? this.isTranslating,
        history: history ?? this.history,
        error: error ?? this.error,
      );
}
