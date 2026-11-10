import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../ai/engine/ai_engine.dart' show AIEngine, ChatMessage;

final languageLearningProvider =
    StateNotifierProvider<LanguageLearningNotifier, LanguageLearningState>((
      ref,
    ) {
      return LanguageLearningNotifier(ref.watch(aiEngineProvider));
    });

class LanguageLearningState {
  final TranslationState translation;
  final ConversationState conversation;
  final GrammarState grammar;
  final VocabularyState vocabulary;

  const LanguageLearningState({
    this.translation = const TranslationState(),
    this.conversation = const ConversationState(),
    this.grammar = const GrammarState(),
    this.vocabulary = const VocabularyState(),
  });

  LanguageLearningState copyWith({
    TranslationState? translation,
    ConversationState? conversation,
    GrammarState? grammar,
    VocabularyState? vocabulary,
  }) => LanguageLearningState(
    translation: translation ?? this.translation,
    conversation: conversation ?? this.conversation,
    grammar: grammar ?? this.grammar,
    vocabulary: vocabulary ?? this.vocabulary,
  );
}

class TranslationState {
  final String sourceText;
  final String translatedText;
  final String sourceLang;
  final String targetLang;
  final bool isTranslating;
  final String? error;

  const TranslationState({
    this.sourceText = '',
    this.translatedText = '',
    this.sourceLang = 'en',
    this.targetLang = 'hi',
    this.isTranslating = false,
    this.error,
  });

  TranslationState copyWith({
    String? sourceText,
    String? translatedText,
    String? sourceLang,
    String? targetLang,
    bool? isTranslating,
    String? error,
  }) => TranslationState(
    sourceText: sourceText ?? this.sourceText,
    translatedText: translatedText ?? this.translatedText,
    sourceLang: sourceLang ?? this.sourceLang,
    targetLang: targetLang ?? this.targetLang,
    isTranslating: isTranslating ?? this.isTranslating,
    error: error ?? this.error,
  );
}

class ConversationState {
  final List<ConversationMessage> messages;
  final String currentInput;
  final String targetLanguage;
  final bool isGenerating;
  final String? error;

  const ConversationState({
    this.messages = const [],
    this.currentInput = '',
    this.targetLanguage = 'en',
    this.isGenerating = false,
    this.error,
  });

  ConversationState copyWith({
    List<ConversationMessage>? messages,
    String? currentInput,
    String? targetLanguage,
    bool? isGenerating,
    String? error,
  }) => ConversationState(
    messages: messages ?? this.messages,
    currentInput: currentInput ?? this.currentInput,
    targetLanguage: targetLanguage ?? this.targetLanguage,
    isGenerating: isGenerating ?? this.isGenerating,
    error: error ?? this.error,
  );
}

class ConversationMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  const ConversationMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

class GrammarState {
  final String query;
  final String explanation;
  final String language;
  final bool isLoading;
  final String? error;

  const GrammarState({
    this.query = '',
    this.explanation = '',
    this.language = 'en',
    this.isLoading = false,
    this.error,
  });

  GrammarState copyWith({
    String? query,
    String? explanation,
    String? language,
    bool? isLoading,
    String? error,
  }) => GrammarState(
    query: query ?? this.query,
    explanation: explanation ?? this.explanation,
    language: language ?? this.language,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
  );
}

class VocabularyItem {
  final String word;
  final String definition;
  final String example;
  final String? pronunciation;

  const VocabularyItem({
    required this.word,
    required this.definition,
    required this.example,
    this.pronunciation,
  });
}

class VocabularyState {
  final List<String> topics;
  final String language;
  final List<VocabularyItem> items;
  final bool isLoading;
  final String? error;

  const VocabularyState({
    this.topics = const [],
    this.language = 'en',
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  VocabularyState copyWith({
    List<String>? topics,
    String? language,
    List<VocabularyItem>? items,
    bool? isLoading,
    String? error,
  }) => VocabularyState(
    topics: topics ?? this.topics,
    language: language ?? this.language,
    items: items ?? this.items,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
  );
}

class LanguageLearningNotifier extends StateNotifier<LanguageLearningState> {
  final AIEngine _aiEngine;

  LanguageLearningNotifier(this._aiEngine)
    : super(const LanguageLearningState());

  // ==================== Translation ====================
  Future<void> translate({
    required String text,
    required String fromLang,
    required String toLang,
  }) async {
    if (text.trim().isEmpty) return;

    state = state.copyWith(
      translation: state.translation.copyWith(
        sourceText: text,
        sourceLang: fromLang,
        targetLang: toLang,
        isTranslating: true,
        error: null,
      ),
    );

    try {
      final prompt = _buildTranslationPrompt(text, fromLang, toLang);
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

      state = state.copyWith(
        translation: state.translation.copyWith(
          translatedText: result,
          isTranslating: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        translation: state.translation.copyWith(
          isTranslating: false,
          error: e.toString(),
        ),
      );
    }
  }

  void setTranslationLanguages(String source, String target) {
    state = state.copyWith(
      translation: state.translation.copyWith(
        sourceLang: source,
        targetLang: target,
      ),
    );
  }

  void setSourceText(String text) {
    state = state.copyWith(
      translation: state.translation.copyWith(sourceText: text),
    );
  }

  // ==================== Conversation Practice ====================
  Future<void> conversationPractice({
    required String message,
    required String language,
  }) async {
    if (message.trim().isEmpty) return;

    final userMsg = ConversationMessage(
      content: message,
      isUser: true,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      conversation: state.conversation.copyWith(
        messages: [...state.conversation.messages, userMsg],
        currentInput: '',
        targetLanguage: language,
        isGenerating: true,
        error: null,
      ),
    );

    try {
      final history =
          state.conversation.messages
              .map(
                (m) => ChatMessage(
                  role: m.isUser ? 'user' : 'assistant',
                  content: m.content,
                  timestamp: m.timestamp,
                ),
              )
              .toList();

      final prompt = _buildConversationPrompt(message, language);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: history,
        systemPrompt: _buildConversationSystemPrompt(language),
        maxTokens: 256,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final response = buffer.toString().trim();

      final aiMsg = ConversationMessage(
        content: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        conversation: state.conversation.copyWith(
          messages: [...state.conversation.messages, aiMsg],
          isGenerating: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        conversation: state.conversation.copyWith(
          isGenerating: false,
          error: e.toString(),
        ),
      );
    }
  }

  void setConversationInput(String input) {
    state = state.copyWith(
      conversation: state.conversation.copyWith(currentInput: input),
    );
  }

  void setConversationLanguage(String language) {
    state = state.copyWith(
      conversation: state.conversation.copyWith(targetLanguage: language),
    );
  }

  void clearConversation() {
    state = state.copyWith(conversation: const ConversationState());
  }

  // ==================== Grammar Explanation ====================
  Future<void> explainGrammar({
    required String query,
    required String language,
  }) async {
    if (query.trim().isEmpty) return;

    state = state.copyWith(
      grammar: state.grammar.copyWith(
        query: query,
        language: language,
        isLoading: true,
        error: null,
      ),
    );

    try {
      final prompt = _buildGrammarPrompt(query, language);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 768,
        temperature: 0.5,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final explanation = buffer.toString().trim();

      state = state.copyWith(
        grammar: state.grammar.copyWith(
          explanation: explanation,
          isLoading: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        grammar: state.grammar.copyWith(isLoading: false, error: e.toString()),
      );
    }
  }

  void setGrammarQuery(String query) {
    state = state.copyWith(grammar: state.grammar.copyWith(query: query));
  }

  void setGrammarLanguage(String language) {
    state = state.copyWith(grammar: state.grammar.copyWith(language: language));
  }

  // ==================== Vocabulary Generation ====================
  Future<void> generateVocabulary({
    required List<String> topics,
    required String language,
  }) async {
    if (topics.isEmpty) return;

    state = state.copyWith(
      vocabulary: state.vocabulary.copyWith(
        topics: topics,
        language: language,
        isLoading: true,
        error: null,
      ),
    );

    try {
      final prompt = _buildVocabularyPrompt(topics, language);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 1024,
        temperature: 0.6,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final items = _parseVocabularyResponse(buffer.toString());

      state = state.copyWith(
        vocabulary: state.vocabulary.copyWith(items: items, isLoading: false),
      );
    } catch (e) {
      state = state.copyWith(
        vocabulary: state.vocabulary.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  void setVocabularyTopics(List<String> topics) {
    state = state.copyWith(
      vocabulary: state.vocabulary.copyWith(topics: topics),
    );
  }

  void setVocabularyLanguage(String language) {
    state = state.copyWith(
      vocabulary: state.vocabulary.copyWith(language: language),
    );
  }

  // ==================== Sentence Generation ====================
  Future<void> generateSentences({
    required String level,
    required String language,
  }) async {
    state = state.copyWith(
      vocabulary: state.vocabulary.copyWith(
        language: language,
        isLoading: true,
        error: null,
      ),
    );

    try {
      final prompt = _buildSentencePrompt(level, language);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 768,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final items = _parseSentencesResponse(buffer.toString(), level);

      state = state.copyWith(
        vocabulary: state.vocabulary.copyWith(items: items, isLoading: false),
      );
    } catch (e) {
      state = state.copyWith(
        vocabulary: state.vocabulary.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  // ==================== Prompt Builders ====================
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
      'pt': 'Portuguese',
      'it': 'Italian',
    };
    return names[code] ?? code;
  }

  String _buildTranslationPrompt(String text, String fromLang, String toLang) {
    return '''
<<SYS>>
You are a translator. Translate the following text from ${_langName(fromLang)} to ${_langName(toLang)}. Output only the translation, no explanations.
<</SYS>>

<<USER>>
$text
</USER>>

<<ASSISTANT>>
''';
  }

  String _buildConversationSystemPrompt(String language) {
    return '''
<<SYS>>
You are a friendly language tutor helping someone practice ${_langName(language)}. 
- Respond naturally in ${_langName(language)}
- Keep responses concise and conversational
- Correct mistakes gently by providing the correct form
- Encourage the learner
- Use simple vocabulary appropriate for a learner
<</SYS>>
''';
  }

  String _buildConversationPrompt(String message, String language) {
    return message;
  }

  String _buildGrammarPrompt(String query, String language) {
    return '''
<<SYS>>
You are a grammar expert teaching ${_langName(language)}. Explain the grammar concept clearly with examples.
<</SYS>>

<<USER>>
Explain this grammar concept in ${_langName(language)}: $query

Provide:
1. A clear explanation
2. 2-3 examples
3. Common mistakes to avoid
</USER>>

<<ASSISTANT>>
''';
  }

  String _buildVocabularyPrompt(List<String> topics, String language) {
    return '''
<<SYS>>
You are a vocabulary teacher. Generate a list of useful vocabulary words.
<</SYS>>

<<USER>>
Generate 10 vocabulary words for topics: ${topics.join(', ')} in ${_langName(language)}.

For each word provide:
- The word
- Definition in English
- Example sentence in ${_langName(language)}
- Pronunciation guide (if helpful)

Format each as: WORD | DEFINITION | EXAMPLE | PRONUNCIATION
</USER>>

<<ASSISTANT>>
''';
  }

  String _buildSentencePrompt(String level, String language) {
    return '''
<<SYS>>
You are a sentence generation teacher. Create practice sentences for language learners.
<</SYS>>

<<USER>>
Generate 10 practice sentences for ${_langName(language)} at $level level.

For each sentence provide:
- The sentence in ${_langName(language)}
- English translation
- Key vocabulary or grammar point

Format each as: SENTENCE | TRANSLATION | NOTES
</USER>>

<<ASSISTANT>>
''';
  }

  List<VocabularyItem> _parseVocabularyResponse(String response) {
    final items = <VocabularyItem>[];
    final lines = response.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final parts = line.split('|').map((s) => s.trim()).toList();
      if (parts.length >= 3) {
        items.add(
          VocabularyItem(
            word: parts[0],
            definition: parts[1],
            example: parts[2],
            pronunciation: parts.length > 3 ? parts[3] : null,
          ),
        );
      }
    }

    return items;
  }

  List<VocabularyItem> _parseSentencesResponse(String response, String level) {
    final items = <VocabularyItem>[];
    final lines = response.split('\n');

    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      final parts = line.split('|').map((s) => s.trim()).toList();
      if (parts.length >= 2) {
        items.add(
          VocabularyItem(
            word: parts[0],
            definition: '${parts[1]} ($level level)',
            example: parts.length > 2 ? parts[2] : '',
          ),
        );
      }
    }

    return items;
  }
}
