import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  const QuizState({
    this.isGenerating = false,
    this.isInProgress = false,
    this.questions = const [],
    this.currentIndex = 0,
    this.correctCount = 0,
    this.topic = '',
  });
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(),
);

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(const QuizState());

  void setTopic(String topic) {
    state = QuizState(topic: topic);
  }

  Future<void> generateQuiz({String topic = ''}) async {
    final quizTopic = topic.isNotEmpty ? topic : state.topic;
    state = state.copyWith(isGenerating: true);
    await Future.delayed(const Duration(milliseconds: 500));

    final questions = <QuizQuestion>[
      for (int i = 0; i < 5; i++)
        QuizQuestion(
          id: i + 1,
          question: 'Question $i about $quizTopic?',
          options: 'A) Option A\nB) Option B\nC) Option C\nD) Option D',
          correctAnswer: 'A',
          type: QuizType.mcq,
        ),
    ];

    state = QuizState(
      isGenerating: false,
      isInProgress: true,
      questions: questions,
      topic: quizTopic,
    );
  }

  void submitAnswer(int questionIndex, String answer) {
    final question = state.questions[questionIndex];
    final isCorrect = answer == question.correctAnswer;

    state = QuizState(
      isInProgress: state.isInProgress,
      questions: state.questions,
      currentIndex: state.currentIndex + 1,
      correctCount: state.correctCount + (isCorrect ? 1 : 0),
      topic: state.topic,
    );

    if (state.currentIndex + 1 >= state.questions.length) {
      state = state.copyWith(isInProgress: false);
    }
  }

  void reset() {
    state = const QuizState();
  }
}

extension on QuizState {
  QuizState copyWith({
    bool? isGenerating,
    bool? isInProgress,
    List<QuizQuestion>? questions,
    int? currentIndex,
    int? correctCount,
    String? topic,
  }) => QuizState(
    isGenerating: isGenerating ?? this.isGenerating,
    isInProgress: isInProgress ?? this.isInProgress,
    questions: questions ?? this.questions,
    currentIndex: currentIndex ?? this.currentIndex,
    correctCount: correctCount ?? this.correctCount,
    topic: topic ?? this.topic,
  );
}
