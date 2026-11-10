import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../../ai/engine/ai_engine.dart';

class QuizQuestion {
  final int id;
  final String question;
  final String? options;
  final String? correctAnswer;
  final String? explanation;
  final QuizType type;

  const QuizQuestion({
    required this.id,
    required this.question,
    this.options,
    this.correctAnswer,
    this.explanation,
    this.type = QuizType.mcq,
  });
}

enum QuizType { mcq, trueFalse, fillBlank, shortAnswer }

class QuizState {
  final bool isGenerating;
  final bool isInProgress;
  final List<QuizQuestion> questions;
  final int currentIndex;
  final int correctCount;
  final String topic;
  final String? error;

  const QuizState({
    this.isGenerating = false,
    this.isInProgress = false,
    this.questions = const [],
    this.currentIndex = 0,
    this.correctCount = 0,
    this.topic = '',
    this.error,
  });

  QuizState copyWith({
    bool? isGenerating,
    bool? isInProgress,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? correctCount,
    String? topic,
    String? error,
  }) => QuizState(
    isGenerating: isGenerating ?? this.isGenerating,
    isInProgress: isInProgress ?? this.isInProgress,
    questions: questions ?? this.questions,
    currentIndex: currentIndex ?? this.currentIndex,
    correctCount: correctCount ?? this.correctCount,
    topic: topic ?? this.topic,
    error: error ?? this.error,
  );
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(ref.watch(aiEngineProvider)),
);

class QuizNotifier extends StateNotifier<QuizState> {
  final AIEngine _aiEngine;

  QuizNotifier(this._aiEngine) : super(const QuizState());

  void setTopic(String topic) {
    state = state.copyWith(topic: topic);
  }

  Future<void> generateQuiz({String topic = ''}) async {
    final quizTopic = topic.isNotEmpty ? topic : state.topic;
    if (quizTopic.trim().isEmpty) {
      state = state.copyWith(error: 'Enter a topic first');
      return;
    }

    state = state.copyWith(isGenerating: true, error: null);

    try {
      final prompt = _buildPrompt(quizTopic);
      final buffer = StringBuffer();

      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        maxTokens: 1024,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final questions = _parseQuiz(buffer.toString(), quizTopic);

      state = state.copyWith(
        isGenerating: false,
        isInProgress: true,
        questions: questions,
        topic: quizTopic,
        currentIndex: 0,
        correctCount: 0,
      );
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
    }
  }

  void submitAnswer(int questionIndex, String answer) {
    final question = state.questions[questionIndex];
    final isCorrect = answer == question.correctAnswer;

    state = state.copyWith(
      currentIndex: state.currentIndex + 1,
      correctCount: state.correctCount + (isCorrect ? 1 : 0),
    );

    if (state.currentIndex + 1 >= state.questions.length) {
      state = state.copyWith(isInProgress: false);
    }
  }

  void reset() {
    state = const QuizState();
  }

  String _buildPrompt(String topic) {
    return '''
<<SYS>>
You are a quiz generator. Create 5 multiple-choice questions about the given topic.
Format each question as:
Q: [question text]
A) [option]
B) [option]
C) [option]
D) [option]
Answer: [A/B/C/D]
Explanation: [brief explanation]

---
<</SYS>>

<<USER>>
Topic: $topic
</USER>>

<<ASSISTANT>>
''';
  }

  List<QuizQuestion> _parseQuiz(String response, String topic) {
    final questions = <QuizQuestion>[];
    final blocks = response.split('Q:');

    for (int i = 1; i < blocks.length && questions.length < 5; i++) {
      final block = blocks[i].trim();
      final lines = block.split('\n');
      if (lines.isEmpty) continue;

      final questionText = lines[0].trim();
      final optionsBuffer = StringBuffer();
      String? answer;
      String? explanation;

      for (final line in lines.skip(1)) {
        if (line.startsWith('A)') ||
            line.startsWith('B)') ||
            line.startsWith('C)') ||
            line.startsWith('D)')) {
          optionsBuffer.write(line);
          optionsBuffer.write('\n');
        } else if (line.startsWith('Answer:')) {
          answer = line.substring('Answer:'.length).trim();
        } else if (line.startsWith('Explanation:')) {
          explanation = line.substring('Explanation:'.length).trim();
        }
      }
      final options =
          optionsBuffer.isEmpty ? null : optionsBuffer.toString().trim();

      if (questionText.isNotEmpty && answer != null) {
        questions.add(
          QuizQuestion(
            id: questions.length + 1,
            question: questionText,
            options: options?.trim(),
            correctAnswer: answer,
            explanation: explanation,
            type: QuizType.mcq,
          ),
        );
      }
    }

    // Fallback if parsing fails
    if (questions.isEmpty) {
      for (int i = 0; i < 5; i++) {
        questions.add(
          QuizQuestion(
            id: i + 1,
            question: 'Question $i about $topic?',
            options: 'A) Option A\nB) Option B\nC) Option C\nD) Option D',
            correctAnswer: 'A',
            type: QuizType.mcq,
          ),
        );
      }
    }

    return questions;
  }
}
