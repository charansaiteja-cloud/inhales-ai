/// FSRS (Free Recall Scheduler) Algorithm for Spaced Repetition.
/// 
/// Based on the FSRS algorithm for optimal review scheduling.
/// Given a flashcard state + user rating (Again=1, Hard=2, Good=3, Easy=4),
/// computes new stability, difficulty, scheduled days, and due date.
library;

/// FSRS parameters for scheduling algorithm.
class FSRSParameters {
  /// Target retention rate (0.75 = 75% recall probability).
  final double requestRetention;
  
  /// Maximum interval between reviews in days.
  final int maximumInterval;
  
  /// Bonus multiplier for Easy rating.
  final double easyBonus;
  
  /// Factor for Hard rating (typically < 1.0).
  final double hardFactor;
  
  /// Minimum interval for new cards (days).
  final int newCardInterval;
  
  /// Learning step interval (minutes).
  final int learningStepMinutes;
  
  /// Relearning step interval (minutes).
  final int relearningStepMinutes;
  
  /// Difficulty multiplier for stability calculation.
  final double difficultyMultiplier;
  
  /// Weight for stability decay.
  final double decayWeight;

  const FSRSParameters({
    this.requestRetention = 0.9,
    this.maximumInterval = 365,
    this.easyBonus = 1.3,
    this.hardFactor = 0.8,
    this.newCardInterval = 1,
    this.learningStepMinutes = 1,
    this.relearningStepMinutes = 10,
    this.difficultyMultiplier = 0.5,
    this.decayWeight = 0.4,
  });

  FSRSParameters copyWith({
    double? requestRetention,
    int? maximumInterval,
    double? easyBonus,
    double? hardFactor,
    int? newCardInterval,
    int? learningStepMinutes,
    int? relearningStepMinutes,
    double? difficultyMultiplier,
    double? decayWeight,
  }) {
    return FSRSParameters(
      requestRetention: requestRetention ?? this.requestRetention,
      maximumInterval: maximumInterval ?? this.maximumInterval,
      easyBonus: easyBonus ?? this.easyBonus,
      hardFactor: hardFactor ?? this.hardFactor,
      newCardInterval: newCardInterval ?? this.newCardInterval,
      learningStepMinutes: learningStepMinutes ?? this.learningStepMinutes,
      relearningStepMinutes: relearningStepMinutes ?? this.relearningStepMinutes,
      difficultyMultiplier: difficultyMultiplier ?? this.difficultyMultiplier,
      decayWeight: decayWeight ?? this.decayWeight,
    );
  }
}

/// Flashcard state for FSRS scheduling.
class FSRSState {
  /// Current stability in days (how long memory lasts).
  final double stability;
  
  /// Current difficulty (0-10 scale, higher = harder).
  final double difficulty;
  
  /// Days since last review.
  final int elapsedDays;
  
  /// Currently scheduled interval in days.
  final int scheduledDays;
  
  /// Number of reviews completed.
  final int reviewCount;
  
  /// Number of lapses (forgotten cards).
  final int lapseCount;
  
  /// Whether this is a new card (never reviewed).
  final bool isNew;

  const FSRSState({
    this.stability = 0.0,
    this.difficulty = 5.0,
    this.elapsedDays = 0,
    this.scheduledDays = 0,
    this.reviewCount = 0,
    this.lapseCount = 0,
    this.isNew = true,
  });

  FSRSState copyWith({
    double? stability,
    double? difficulty,
    int? elapsedDays,
    int? scheduledDays,
    int? reviewCount,
    int? lapseCount,
    bool? isNew,
  }) {
    return FSRSState(
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      elapsedDays: elapsedDays ?? this.elapsedDays,
      scheduledDays: scheduledDays ?? this.scheduledDays,
      reviewCount: reviewCount ?? this.reviewCount,
      lapseCount: lapseCount ?? this.lapseCount,
      isNew: isNew ?? this.isNew,
    );
  }
}

/// User rating for a flashcard review.
enum FlashcardRating {
  again(1),   // Complete forget, needs immediate relearn
  hard(2),    // Difficult recall, short interval
  good(3),    // Normal recall, standard interval
  easy(4);    // Easy recall, extended interval

  final int value;
  const FlashcardRating(this.value);

  static FlashcardRating fromInt(int value) {
    switch (value) {
      case 1: return FlashcardRating.again;
      case 2: return FlashcardRating.hard;
      case 3: return FlashcardRating.good;
      case 4: return FlashcardRating.easy;
      default: return FlashcardRating.good;
    }
  }
}

/// Result of an FSRS review calculation.
class FSRSResult {
  /// Updated stability in days.
  final double stability;
  
  /// Updated difficulty (0-10 scale).
  final double difficulty;
  
  /// New scheduled interval in days.
  final int scheduledDays;
  
  /// Due date for next review.
  final DateTime dueDate;
  
  /// Updated review count.
  final int reviewCount;
  
  /// Updated lapse count.
  final int lapseCount;

  const FSRSResult({
    required this.stability,
    required this.difficulty,
    required this.scheduledDays,
    required this.dueDate,
    required this.reviewCount,
    required this.lapseCount,
  });
}

/// Initialize FSRS state for a new flashcard.
FSRSState fsrsInit() {
  return const FSRSState(
    stability: 0.0,
    difficulty: 5.0,
    elapsedDays: 0,
    scheduledDays: 0,
    reviewCount: 0,
    lapseCount: 0,
    isNew: true,
  );
}

/// Calculate next review state based on current state and user rating.
/// 
/// This implements a simplified FSRS algorithm:
/// - Again (1): Reset to learning step, increment lapse count
/// - Hard (2): Short interval (3x current or minimum)
/// - Good (3): Standard interval based on stability
/// - Easy (4): Extended interval with bonus multiplier
FSRSResult fsrsNext(
  FSRSState state,
  FlashcardRating rating,
  FSRSParameters params,
) {
  final now = DateTime.now();
  double newStability;
  double newDifficulty;
  int newScheduledDays;
  int newReviewCount = state.reviewCount + 1;
  int newLapseCount = state.lapseCount;

  // Calculate elapsed days since last review
  final elapsedDays = state.elapsedDays;

  switch (rating) {
    case FlashcardRating.again:
      // Complete forget - reset to learning state
      newStability = params.learningStepMinutes / 1440.0; // Convert minutes to days
      newDifficulty = _clampDifficulty(state.difficulty + 2.0);
      newScheduledDays = 0; // Review again today (or in learningStepMinutes)
      newLapseCount = state.lapseCount + 1;
      break;

    case FlashcardRating.hard:
      // Difficult recall - conservative interval increase
      newStability = _calculateStability(
        currentStability: state.stability,
        rating: rating,
        difficulty: state.difficulty,
        elapsedDays: elapsedDays,
        params: params,
      );
      newDifficulty = _clampDifficulty(state.difficulty + 0.5);
      newScheduledDays = _calculateInterval(
        stability: newStability,
        rating: rating,
        params: params,
        currentInterval: state.scheduledDays,
      );
      break;

    case FlashcardRating.good:
      // Normal recall - standard FSRS calculation
      newStability = _calculateStability(
        currentStability: state.stability,
        rating: rating,
        difficulty: state.difficulty,
        elapsedDays: elapsedDays,
        params: params,
      );
      newDifficulty = _clampDifficulty(state.difficulty);
      newScheduledDays = _calculateInterval(
        stability: newStability,
        rating: rating,
        params: params,
        currentInterval: state.scheduledDays,
      );
      break;

    case FlashcardRating.easy:
      // Easy recall - extended interval with bonus
      newStability = _calculateStability(
        currentStability: state.stability,
        rating: rating,
        difficulty: state.difficulty,
        elapsedDays: elapsedDays,
        params: params,
      );
      newDifficulty = _clampDifficulty(state.difficulty - 0.5);
      newScheduledDays = _calculateInterval(
        stability: newStability,
        rating: rating,
        params: params,
        currentInterval: state.scheduledDays,
      );
      break;
  }

  // Calculate due date
  final dueDate = now.add(Duration(days: newScheduledDays));

  return FSRSResult(
    stability: newStability,
    difficulty: newDifficulty,
    scheduledDays: newScheduledDays,
    dueDate: dueDate,
    reviewCount: newReviewCount,
    lapseCount: newLapseCount,
  );
}

/// Calculate new stability based on rating and current state.
double _calculateStability({
  required double currentStability,
  required FlashcardRating rating,
  required double difficulty,
  required int elapsedDays,
  required FSRSParameters params,
}) {
  // For new cards, use base stability
  if (currentStability == 0.0) {
    return _getBaseStability(rating, params);
  }

  // Calculate retention probability using exponential decay
  final retention = _calculateRetention(currentStability, elapsedDays);
  
  // Adjust stability based on rating and retention
  double stabilityFactor;
  switch (rating) {
    case FlashcardRating.again:
      stabilityFactor = 0.5; // Reduce stability significantly
      break;
    case FlashcardRating.hard:
      stabilityFactor = 1.2; // Slight increase
      break;
    case FlashcardRating.good:
      stabilityFactor = 1.5; // Standard increase
      break;
    case FlashcardRating.easy:
      stabilityFactor = 2.0; // Significant increase
      break;
  }

  // Apply difficulty modifier (harder cards learn slower)
  final difficultyModifier = 1.0 - ((difficulty - 5.0) * params.difficultyMultiplier * 0.1);
  
  // Calculate new stability
  final newStability = currentStability * stabilityFactor * difficultyModifier;
  
  // Apply decay weight for forgetting curve
  if (elapsedDays > currentStability) {
    return newStability * params.decayWeight;
  }
  
  return newStability;
}

/// Calculate base stability for new cards.
double _getBaseStability(FlashcardRating rating, FSRSParameters params) {
  switch (rating) {
    case FlashcardRating.again:
      return 0.0;
    case FlashcardRating.hard:
      return 0.5;
    case FlashcardRating.good:
      return 1.0;
    case FlashcardRating.easy:
      return 2.0;
  }
}

/// Calculate retention probability using exponential forgetting curve.
double _calculateRetention(double stability, int elapsedDays) {
  if (stability <= 0) return 0.0;
  // Ebbinghaus forgetting curve: R = e^(-t/S)
  return _exp(-elapsedDays / stability);
}

/// Calculate next review interval in days.
int _calculateInterval({
  required double stability,
  required FlashcardRating rating,
  required FSRSParameters params,
  required int currentInterval,
}) {
  // Base interval from stability
  double interval = stability;
  
  // Apply rating modifier
  switch (rating) {
    case FlashcardRating.again:
      // Again means relearn - use minimum interval
      return params.newCardInterval;
    case FlashcardRating.hard:
      // Hard rating - conservative increase
      if (currentInterval > 0) {
        interval = (currentInterval * params.hardFactor).toDouble();
      } else {
        interval = params.newCardInterval.toDouble();
      }
      break;
    case FlashcardRating.good:
      // Good rating - standard interval from stability
      if (currentInterval > 0) {
        interval = stability;
      } else {
        interval = params.newCardInterval.toDouble();
      }
      break;
    case FlashcardRating.easy:
      // Easy rating - bonus multiplier
      if (currentInterval > 0) {
        interval = stability * params.easyBonus;
      } else {
        interval = params.newCardInterval * 2;
      }
      break;
  }
  
  // Clamp to valid range
  interval = interval.clamp(1.0, params.maximumInterval.toDouble());
  
  return interval.round();
}

/// Clamp difficulty to valid range (0-10).
double _clampDifficulty(double difficulty) {
  return difficulty.clamp(0.0, 10.0);
}

/// Exponential function helper.
double _exp(double x) {
  return _pow(2.718281828459045, x);
}

/// Power function helper.
double _pow(double base, double exp) {
  if (exp == 0) return 1.0;
  if (exp < 0) return 1.0 / _pow(base, -exp);
  
  double result = 1.0;
  double b = base;
  double e = exp;
  
  while (e > 0) {
    if (e % 2 == 1) {
      result *= b;
    }
    b *= b;
    e /= 2;
  }
  
  return result;
}

/// Calculate predicted retention for a given stability and elapsed days.
double calculatePredictedRetention(double stability, int elapsedDays) {
  return _calculateRetention(stability, elapsedDays);
}

/// Calculate optimal review interval for target retention.
int calculateOptimalInterval({
  required double targetRetention,
  required double currentStability,
  required FSRSParameters params,
}) {
  // Find interval where retention equals target
  // R = e^(-t/S) => t = -S * ln(R)
  final lnRetention = _ln(targetRetention);
  final optimalDays = -currentStability * lnRetention;
  return optimalDays.clamp(1.0, params.maximumInterval.toDouble()).round();
}

/// Natural logarithm helper.
double _ln(double x) {
  if (x <= 0) return double.negativeInfinity;
  if (x == 1) return 0;
  
  // Use Newton's method for ln calculation
  double result = 0.0;
  double y = (x - 1) / (x + 1);
  double y2 = y * y;
  double term = y;
  
  for (int i = 0; i < 50; i++) {
    result += term / (2 * i + 1);
    term *= y2;
    if (term.abs() < 1e-10) break;
  }
  
  return 2 * result;
}
