import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart' as db;
import '../../di/di.dart';
import '../../ai/engine/ai_engine.dart';

// ═══════════════════════════════════════════════════════════════════
// Data Models
// ═══════════════════════════════════════════════════════════════════

/// Display-friendly wrapper for a Recommendation row.
class RecommendationViewModel {
  final int id;
  final String type;
  final String title;
  final String description;
  final String reason;
  final int priority;
  final int? topicId;
  final int? resourceId;
  final bool isDismissed;
  final bool isAccepted;
  final DateTime? expiresAt;
  final DateTime createdAt;

  const RecommendationViewModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.reason,
    required this.priority,
    this.topicId,
    this.resourceId,
    required this.isDismissed,
    required this.isAccepted,
    this.expiresAt,
    required this.createdAt,
  });

  factory RecommendationViewModel.fromTable(db.Recommendation rec) {
    return RecommendationViewModel(
      id: rec.id,
      type: rec.type,
      title: rec.title,
      description: rec.description,
      reason: rec.reason,
      priority: rec.priority,
      topicId: rec.topicId,
      resourceId: rec.resourceId,
      isDismissed: rec.isDismissed,
      isAccepted: rec.isAccepted,
      expiresAt: rec.expiresAt,
      createdAt: rec.createdAt,
    );
  }

  /// Priority label for display.
  String get priorityLabel {
    switch (priority) {
      case 1:
        return 'High';
      case 2:
        return 'Medium';
      case 3:
        return 'Low';
      default:
        return 'Normal';
    }
  }

  /// Icon based on recommendation type.
  IconData get typeIcon {
    switch (type.toLowerCase()) {
      case 'topic':
        return Icons.auto_awesome_rounded;
      case 'resource':
        return Icons.menu_book_rounded;
      case 'quiz':
        return Icons.quiz_rounded;
      case 'flashcard':
        return Icons.auto_awesome_rounded;
      case 'review':
        return Icons.refresh_rounded;
      case 'schedule':
        return Icons.schedule_rounded;
      default:
        return Icons.recommend_rounded;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════
// State classes
// ═══════════════════════════════════════════════════════════════════

class RecommendationsState {
  final List<RecommendationViewModel> recommendations;
  final List<RecommendationViewModel> activeRecommendations;
  final bool isLoading;
  final String? error;
  final String? filterType;
  final bool isGenerating;

  const RecommendationsState({
    this.recommendations = const [],
    this.activeRecommendations = const [],
    this.isLoading = false,
    this.error,
    this.filterType,
    this.isGenerating = false,
  });

  RecommendationsState copyWith({
    List<RecommendationViewModel>? recommendations,
    List<RecommendationViewModel>? activeRecommendations,
    bool? isLoading,
    String? error,
    String? filterType,
    bool? isGenerating,
  }) =>
      RecommendationsState(
        recommendations: recommendations ?? this.recommendations,
        activeRecommendations:
            activeRecommendations ?? this.activeRecommendations,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        filterType: filterType ?? this.filterType,
        isGenerating: isGenerating ?? this.isGenerating,
      );

  /// Filtered list based on current filter.
  List<RecommendationViewModel> get filteredRecommendations {
    var list = activeRecommendations;
    if (filterType != null && filterType!.isNotEmpty) {
      list = list.where((r) => r.type == filterType).toList();
    }
    // Sort by priority (1=high first), then by date
    list.sort((a, b) {
      if (a.priority != b.priority) return a.priority - b.priority;
      return b.createdAt.compareTo(a.createdAt);
    });
    return list;
  }

  /// Available filter types from current recommendations.
  Set<String> get availableTypes {
    return activeRecommendations.map((r) => r.type).toSet();
  }
}

// ═══════════════════════════════════════════════════════════════════
// Providers
// ═══════════════════════════════════════════════════════════════════

final recommendationsProvider =
    StateNotifierProvider<RecommendationsNotifier, RecommendationsState>(
  (ref) => RecommendationsNotifier(
    ref.watch(databaseProvider),
    ref.watch(aiEngineProvider),
  ),
);

/// Convenience provider for all active recommendations.
final activeRecommendationsProvider = Provider<List<RecommendationViewModel>>((
  ref,
) {
  return ref.watch(
    recommendationsProvider.select((s) => s.activeRecommendations),
  );
});

/// Convenience provider for filtered recommendations.
final filteredRecommendationsProvider = Provider<List<RecommendationViewModel>>(
  (ref) {
    return ref.watch(
      recommendationsProvider.select((s) => s.filteredRecommendations),
    );
  },
);

// ═══════════════════════════════════════════════════════════════════
// Notifier
// ═══════════════════════════════════════════════════════════════════

class RecommendationsNotifier extends StateNotifier<RecommendationsState> {
  final db.AppDatabase _db;
  final AIEngine _aiEngine;

  RecommendationsNotifier(this._db, this._aiEngine)
      : super(const RecommendationsState()) {
    _loadRecommendations();
  }

  // ── Data Loading ──────────────────────────────────────────────────

  Future<void> _loadRecommendations() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final recs = await (_db.select(_db.recommendations)
            ..where((t) => t.isDismissed.equals(false))
            ..orderBy([
              (t) => drift.OrderingTerm.asc(t.priority),
              (t) => drift.OrderingTerm.desc(t.createdAt),
            ]))
          .get();

      final viewModels =
          recs.map((r) => RecommendationViewModel.fromTable(r)).toList();

      state = state.copyWith(
        recommendations: viewModels,
        activeRecommendations: viewModels.where((r) => !r.isAccepted).toList(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Set filter type.
  void setFilter(String? type) {
    state = state.copyWith(filterType: type);
  }

  /// Clear filter.
  void clearFilter() {
    state = state.copyWith(filterType: null);
  }

  // ── User Actions ──────────────────────────────────────────────────

  /// Dismiss a recommendation.
  Future<void> dismiss(int id) async {
    try {
      await (_db.update(_db.recommendations)..where((t) => t.id.equals(id)))
          .write(
        db.RecommendationsCompanion(isDismissed: const drift.Value(true)),
      );
      await _loadRecommendations();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Accept a recommendation.
  Future<void> accept(int id) async {
    try {
      await (_db.update(_db.recommendations)..where((t) => t.id.equals(id)))
          .write(
        db.RecommendationsCompanion(isAccepted: const drift.Value(true)),
      );
      await _loadRecommendations();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Dismiss all recommendations.
  Future<void> dismissAll() async {
    try {
      await (_db.update(_db.recommendations)
            ..where((t) => t.isDismissed.equals(false)))
          .write(
        db.RecommendationsCompanion(isDismissed: const drift.Value(true)),
      );
      await _loadRecommendations();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // ── AI Generation ─────────────────────────────────────────────────

  /// Generate AI-based study recommendations.
  Future<void> generateRecommendations() async {
    state = state.copyWith(isGenerating: true, error: null);

    try {
      // Gather context from user's study data
      final context = await _gatherContext();

      // Generate recommendations using AI
      final recommendations = await _aiGenerateRecommendations(context);

      // Save recommendations to database
      for (final rec in recommendations) {
        await _db.into(_db.recommendations).insert(
              db.RecommendationsCompanion(
                type: rec.type,
                title: rec.title,
                description: rec.description,
                reason: rec.reason,
                priority: rec.priority,
                topicId: rec.topicId,
                resourceId: rec.resourceId,
                isDismissed: const drift.Value(false),
                isAccepted: const drift.Value(false),
                createdAt: drift.Value(DateTime.now()),
                expiresAt: drift.Value(
                  DateTime.now().add(const Duration(days: 7)),
                ),
              ),
            );
      }

      await _loadRecommendations();
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
    }
  }

  /// Gather context from user's study history and performance.
  Future<Map<String, dynamic>> _gatherContext() async {
    final context = <String, dynamic>{};

    // Get recent study sessions
    final sessions = await (_db.select(_db.studySessions)
          ..orderBy([(t) => drift.OrderingTerm.desc(t.startedAt)])
          ..limit(10))
        .get();

    context['recentActivities'] = sessions
        .map(
          (s) => {
            'type': s.activityType,
            'duration': s.durationMinutes,
            'focusScore': s.focusScore,
          },
        )
        .toList();

    // Get quiz history
    final quizzes = await (_db.select(_db.quizHistory)
          ..orderBy([(t) => drift.OrderingTerm.desc(t.createdAt)])
          ..limit(5))
        .get();

    context['quizHistory'] = quizzes
        .map(
          (q) => {
            'subject': q.subject,
            'score': q.score,
            'totalQuestions': q.totalQuestions,
            'correctAnswers': q.correctAnswers,
          },
        )
        .toList();

    // Get active study plans
    final plans = await (_db.select(_db.studyPlans)
          ..where((t) => t.isActive.equals(true)))
        .get();

    context['activePlans'] =
        plans.map((p) => {'name': p.name, 'goals': p.goals}).toList();

    // Get upcoming flashcard reviews
    final now = DateTime.now();
    final dueFlashcards = await (_db.select(_db.flashcards)
          ..where(
            (t) => t.dueDate.isSmallerOrEqualValue(now) & t.dueDate.isNotNull(),
          )
          ..limit(10))
        .get();

    context['dueFlashcards'] = dueFlashcards.length;

    // Get weak areas from quiz history (subjects with low scores)

    context['weakAreas'] = _computeWeakAreas(quizzes);

    return context;
  }

  /// Generate recommendations using AI.
  Future<List<db.RecommendationsCompanion>> _aiGenerateRecommendations(
    Map<String, dynamic> context,
  ) async {
    final prompt = _buildPrompt(context);

    final buffer = StringBuffer();
    await for (final chunk in _aiEngine.generate(
      prompt: prompt,
      history: [],
      maxTokens: 512,
      temperature: 0.7,
    )) {
      buffer.write(chunk);
    }

    final response = buffer.toString().trim();
    return _parseRecommendations(response);
  }

  /// Build prompt for AI recommendation generation.
  String _buildPrompt(Map<String, dynamic> context) {
    return '''<<SYS>>
You are a study recommendation engine. Generate personalized study recommendations based on the user's learning data.

Output format: JSON array of recommendation objects with these fields:
- type: "topic", "resource", "quiz", "flashcard", "review", or "schedule"
- title: Short, actionable title
- description: Brief description of what to do
- reason: Why this is recommended (reference the data)
- priority: 1 (high), 2 (medium), or 3 (low)

Generate 3-5 recommendations. Be specific and actionable.
<</SYS>>

<<USER>>
Here is my study data:

Recent Activities: ${jsonEncode(context['recentActivities'])}
Quiz History: ${jsonEncode(context['quizHistory'])}
Active Study Plans: ${jsonEncode(context['activePlans'])}
Flashcards Due: ${context['dueFlashcards']}
Weak Areas: ${jsonEncode(context['weakAreas'])}

Generate personalized recommendations for me.
</USER>>

<<ASSISTANT>>
''';
  }

  /// Parse AI response into recommendation objects.
  List<db.RecommendationsCompanion> _parseRecommendations(String response) {
    try {
      // Try to extract JSON from response
      final jsonStart = response.indexOf('[');
      final jsonEnd = response.lastIndexOf(']');
      if (jsonStart == -1 || jsonEnd == -1) {
        return _fallbackRecommendations();
      }

      final jsonString = response.substring(jsonStart, jsonEnd + 1);
      final decoded = jsonDecode(jsonString) as List;

      return decoded.map((item) {
        final map = item as Map<String, dynamic>;
        return db.RecommendationsCompanion(
          type: drift.Value(map['type']?.toString() ?? 'topic'),
          title: drift.Value(
            map['title']?.toString() ?? 'Study Recommendation',
          ),
          description: drift.Value(map['description']?.toString() ?? ''),
          reason: drift.Value(
            map['reason']?.toString() ?? 'AI-generated recommendation',
          ),
          priority: drift.Value((map['priority'] as num?)?.toInt() ?? 2),
          topicId: const drift.Value.absent(),
          resourceId: const drift.Value.absent(),
          isDismissed: const drift.Value(false),
          isAccepted: const drift.Value(false),
          createdAt: drift.Value(DateTime.now()),
          expiresAt: drift.Value(DateTime.now().add(const Duration(days: 7))),
        );
      }).toList();
    } catch (e) {
      return _fallbackRecommendations();
    }
  }

  /// Fallback recommendations when AI fails.
  List<db.RecommendationsCompanion> _fallbackRecommendations() {
    return [
      db.RecommendationsCompanion(
        type: const drift.Value('review'),
        title: const drift.Value('Review Recent Topics'),
        description: const drift.Value(
          'Spend 15 minutes reviewing what you studied yesterday',
        ),
        reason: const drift.Value('Regular review improves retention'),
        priority: const drift.Value(1),
        topicId: const drift.Value.absent(),
        resourceId: const drift.Value.absent(),
        isDismissed: const drift.Value(false),
        isAccepted: const drift.Value(false),
        createdAt: drift.Value(DateTime.now()),
        expiresAt: drift.Value(DateTime.now().add(const Duration(days: 7))),
      ),
      db.RecommendationsCompanion(
        type: const drift.Value('quiz'),
        title: const drift.Value('Test Your Knowledge'),
        description: const drift.Value(
          'Take a quick quiz on your current subject',
        ),
        reason: const drift.Value('Self-assessment helps identify gaps'),
        priority: const drift.Value(2),
        topicId: const drift.Value.absent(),
        resourceId: const drift.Value.absent(),
        isDismissed: const drift.Value(false),
        isAccepted: const drift.Value(false),
        createdAt: drift.Value(DateTime.now()),
        expiresAt: drift.Value(DateTime.now().add(const Duration(days: 7))),
      ),
      db.RecommendationsCompanion(
        type: const drift.Value('schedule'),
        title: const drift.Value('Plan Your Week'),
        description: const drift.Value(
          'Set aside dedicated study time for upcoming goals',
        ),
        reason: const drift.Value('Consistent scheduling improves progress'),
        priority: const drift.Value(3),
        topicId: const drift.Value.absent(),
        resourceId: const drift.Value.absent(),
        isDismissed: const drift.Value(false),
        isAccepted: const drift.Value(false),
        createdAt: drift.Value(DateTime.now()),
        expiresAt: drift.Value(DateTime.now().add(const Duration(days: 7))),
      ),
    ];
  }

  // ── Refresh ───────────────────────────────────────────────────────

  Future<void> refresh() async {
    await _loadRecommendations();
  }

  /// Helper to compute weak areas from quiz history.
  List<Map<String, dynamic>> _computeWeakAreas(List<dynamic> quizzes) {
    if (quizzes.isEmpty) return [];

    final Map<String, List<int>> subjectScores = {};
    for (final quiz in quizzes.where((q) => (q.score ?? 0) < 70)) {
      final subject = quiz.subject ?? 'Unknown';
      subjectScores.putIfAbsent(subject, () => []).add(quiz.score ?? 0);
    }

    return subjectScores.entries.map((entry) {
      final scores = entry.value;
      final avgScore = scores.reduce((a, b) => a + b) / scores.length;
      return {'subject': entry.key, 'avgScore': avgScore};
    }).toList();
  }
}
