import 'package:flutter_riverpod/flutter_riverpod.dart';

class TranslationState {
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final bool isTranslating;
  final List<TranslationHistory> history;

  const TranslationState({
    this.sourceText = '',
    this.translatedText = '',
    this.sourceLang = 'en',
    this.targetLang = 'hi',
    this.isTranslating = false,
    this.history = const [],
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
      (ref) => TranslationNotifier(),
    );

class TranslationNotifier extends StateNotifier<TranslationState> {
  TranslationNotifier() : super(const TranslationState());

  Future<void> translate(String text) async {
    if (text.trim().isEmpty) return;
    state = TranslationState(
      sourceText: text,
      translatedText: state.translatedText,
      sourceLang: state.sourceLang,
      targetLang: state.targetLang,
      isTranslating: true,
      history: state.history,
    );

    // Real implementation uses local translation model.
    await Future.delayed(const Duration(milliseconds: 800));

    final result =
        state.translatedText.isEmpty
            ? 'Translation requires a language model. Install one from Model Manager.'
            : state.translatedText;

    final historyEntry = TranslationHistory(
      source: text,
      translated: result,
      sourceLang: state.sourceLang,
      targetLang: state.targetLang,
      timestamp: DateTime.now(),
    );

    state = TranslationState(
      sourceText: text,
      translatedText: result,
      sourceLang: state.sourceLang,
      targetLang: state.targetLang,
      isTranslating: false,
      history: [historyEntry, ...state.history],
    );
  }

  Future<void> swapLanguages() async {
    state = TranslationState(
      sourceText: state.translatedText,
      translatedText: state.sourceText,
      sourceLang: state.targetLang,
      targetLang: state.sourceLang,
      isTranslating: false,
      history: state.history,
    );
  }

  Future<void> setLanguages(String src, String tgt) async {
    state = TranslationState(
      sourceText: state.sourceText,
      translatedText: state.translatedText,
      sourceLang: src,
      targetLang: tgt,
      isTranslating: false,
      history: state.history,
    );
  }
}
