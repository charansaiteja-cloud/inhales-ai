/// Riverpod providers for the Study Planner feature.
library;

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database.dart';
import '../../di/di.dart';
import 'scheduling_engine.dart';

// ═══════════════════════════════════════════════════════════════════
// Data Models
// ═══════════════════════════════════════════════════════════════════

/// Display-friendly wrapper for a StudyPlan row.
class StudyPlanViewModel {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> goals;
  final int? targetHoursPerWeek;
  final bool isActive;
  final DateTime createdAt;

  const StudyPlanViewModel({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.goals,
    this.targetHoursPerWeek,
    required this.isActive,
    required this.createdAt,
  });

  int get totalItems => 0; // populated via items provider
  double get progress => 0.0; // populated via items provider

  factory StudyPlanViewModel.fromTable(StudyPlan plan) {
    List<String> goals = [];
    if (plan.goals != null && plan.goals!.isNotEmpty) {
      try {
        final decoded = jsonDecode(plan.goals!) as List;
        goals = decoded.cast<String>();
      } catch (_) {}
    }
    return StudyPlanViewModel(
      id: plan.id,
      name: plan.name,
      description: plan.description,
      startDate: plan.startDate,
      endDate: plan.endDate,
      goals: goals,
      targetHoursPerWeek: plan.targetHoursPerWeek,
      isActive: plan.isActive,
      createdAt: plan.createdAt,
    );
  }
}

/// Display wrapper for a StudyPlanItem row.
class StudyPlanItemViewModel {
  final int id;
  final int planId;
  final int? topicId;
  final int? resourceId;
  final String title;
  final String type;
  final int estimatedMinutes;
  final int orderIndex;
  final DateTime? scheduledDate;
  final bool isCompleted;
  final DateTime? completedAt;

  const StudyPlanItemViewModel({
    required this.id,
    required this.planId,
    this.topicId,
    this.resourceId,
    required this.title,
    required this.type,
    required this.estimatedMinutes,
    required this.orderIndex,
    this.scheduledDate,
    required this.isCompleted,
    this.completedAt,
  });

  factory StudyPlanItemViewModel.fromTable(StudyPlanItem item) {
    return StudyPlanItemViewModel(
      id: item.id,
      planId: item.planId,
      topicId: item.topicId,
      resourceId: item.resourceId,
      title: item.title,
      type: item.type,
      estimatedMinutes: item.estimatedMinutes,
      orderIndex: item.orderIndex,
      scheduledDate: item.scheduledDate,
      isCompleted: item.isCompleted,
      completedAt: item.completedAt,
    );
  }
}

/// Display wrapper for a StudySession row.
class StudySessionViewModel {
  final int id;
  final int? planId;
  final int? planItemId;
  final int? topicId;
  final String activityType;
  final int durationMinutes;
  final int? focusScore;
  final String? notes;
  final DateTime startedAt;
  final DateTime endedAt;

  const StudySessionViewModel({
    required this.id,
    this.planId,
    this.planItemId,
    this.topicId,
    required this.activityType,
    required this.durationMinutes,
    this.focusScore,
    this.notes,
    required this.startedAt,
    required this.endedAt,
  });

  factory StudySessionViewModel.fromTable(StudySession session) {
    return StudySessionViewModel(
      id: session.id,
      planId: session.planId,
      planItemId: session.planItemId,
      topicId: session.topicId,
      activityType: session.activityType,
      durationMinutes: session.durationMinutes,
      focusScore: session.focusScore,
      notes: session.notes,
      startedAt: session.startedAt,
      endedAt: session.endedAt,
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// State classes
// ═══════════════════════════════════════════════════════════════════

class StudyPlanState {
  final List<StudyPlanViewModel> plans;
  final List<StudyPlanItemViewModel> items;
  final List<StudyPlanItemViewModel> todayItems;
  final List<StudySessionViewModel> sessions;
  final StudyPlanViewModel? activePlan;
  final bool isLoading;
  final String? error;
  final int? selectedPlanId;

  const StudyPlanState({
    this.plans = const [],
    this.items = const [],
    this.todayItems = const [],
    this.sessions = const [],
    this.activePlan,
    this.isLoading = false,
    this.error,
    this.selectedPlanId,
  });

  StudyPlanState copyWith({
    List<StudyPlanViewModel>? plans,
    List<StudyPlanItemViewModel>? items,
    List<StudyPlanItemViewModel>? todayItems,
    List<StudySessionViewModel>? sessions,
    StudyPlanViewModel? activePlan,
    bool? isLoading,
    String? error,
    int? selectedPlanId,
  }) => StudyPlanState(
    plans: plans ?? this.plans,
    items: items ?? this.items,
    todayItems: todayItems ?? this.todayItems,
    sessions: sessions ?? this.sessions,
    activePlan: activePlan ?? this.activePlan,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    selectedPlanId: selectedPlanId ?? this.selectedPlanId,
  );

  /// Combined progress across all active plans.
  double get overallProgress {
    if (plans.isEmpty) return 0.0;
    double total = 0;
    for (final plan in plans) {
      if (!plan.isActive) continue;
      final planItems = items.where((i) => i.planId == plan.id).toList();
      if (planItems.isEmpty) continue;
      final completed = planItems.where((i) => i.isCompleted).length;
      total += completed / planItems.length;
    }
    return (total / plans.where((p) => p.isActive).length).clamp(0, 1);
  }
}

// ═══════════════════════════════════════════════════════════════════
// Providers
// ═══════════════════════════════════════════════════════════════════

final studyPlanProvider =
    StateNotifierProvider<StudyPlanNotifier, StudyPlanState>(
      (ref) => StudyPlanNotifier(
        ref.watch(databaseProvider),
        ref.watch(aiEngineProvider),
      ),
    );

/// Convenience provider for all plans (active first).
final studyPlansProvider = Provider<List<StudyPlanViewModel>>((ref) {
  return ref.watch(studyPlanProvider.select((s) => s.plans));
});

/// Convenience provider for items of a specific plan.
final studyPlanItemsProvider =
    Provider.family<List<StudyPlanItemViewModel>, int>((ref, planId) {
      return ref.watch(
        studyPlanProvider.select((s) {
          return s.items.where((i) => i.planId == planId).toList()
            ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
        }),
      );
    });

/// Convenience provider for today's items.
final todayItemsProvider = Provider<List<StudyPlanItemViewModel>>((ref) {
  return ref.watch(studyPlanProvider.select((s) => s.todayItems));
});

/// Convenience provider for recent study sessions.
final studySessionsProvider = Provider<List<StudySessionViewModel>>((ref) {
  return ref.watch(studyPlanProvider.select((s) => s.sessions));
});

// ═══════════════════════════════════════════════════════════════════
// Notifier
// ═══════════════════════════════════════════════════════════════════

class StudyPlanNotifier extends StateNotifier<StudyPlanState> {
  final AppDatabase _db;
  final dynamic _aiEngine;
  final SchedulingEngine _engine = SchedulingEngine();

  StudyPlanNotifier(this._db, this._aiEngine) : super(const StudyPlanState()) {
    _loadAll();
  }

  // ── Data Loading ──────────────────────────────────────────────────

  Future<void> _loadAll() async {
    try {
      await _refreshPlans();
      await _refreshItems();
      await _refreshTodayItems();
      await _refreshSessions();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> _refreshPlans() async {
    final plans = await _db.select(_db.studyPlans).get();
    final viewModels =
        plans.map((p) => StudyPlanViewModel.fromTable(p)).toList()
          ..sort((a, b) {
            // Active first, then by creation date descending
            if (a.isActive != b.isActive) return a.isActive ? -1 : 1;
            return b.createdAt.compareTo(a.createdAt);
          });

    state = state.copyWith(plans: viewModels);

    // Set active plan
    final active = viewModels.where((p) => p.isActive).firstOrNull;
    state = state.copyWith(activePlan: active);
  }

  Future<void> _refreshItems() async {
    final items = await _db.select(_db.studyPlanItems).get();
    state = state.copyWith(
      items: items.map((i) => StudyPlanItemViewModel.fromTable(i)).toList(),
    );
  }

  Future<void> _refreshTodayItems() async {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final tomorrow = today.add(const Duration(days: 1));

    final todayItems =
        await (_db.select(_db.studyPlanItems)
              ..where(
                (i) =>
                    i.scheduledDate.isNotNull() &
                    i.scheduledDate.isBiggerOrEqualValue(today) &
                    i.scheduledDate.isSmallerThanValue(tomorrow),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
            .get();

    state = state.copyWith(
      todayItems:
          todayItems.map((i) => StudyPlanItemViewModel.fromTable(i)).toList(),
    );
  }

  Future<void> _refreshSessions() async {
    final sessions =
        await (_db.select(_db.studySessions)
              ..orderBy([(t) => OrderingTerm.desc(t.startedAt)])
              ..limit(50))
            .get();

    state = state.copyWith(
      sessions:
          sessions.map((s) => StudySessionViewModel.fromTable(s)).toList(),
    );
  }

  Future<void> loadPlan(int planId) async {
    state = state.copyWith(selectedPlanId: planId, isLoading: true);
    await _refreshItems();
    await _refreshTodayItems();
    state = state.copyWith(isLoading: false);
  }

  // ── Plan CRUD ─────────────────────────────────────────────────────

  /// Create a new study plan using the scheduling engine.
  Future<void> createPlan({
    required String name,
    required List<String> goals,
    required DateTime startDate,
    required DateTime endDate,
    required int hoursPerWeek,
    List<int>? topicIds,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Fetch topics if provided
      List<PlanningTopic> topics = [];
      if (topicIds != null && topicIds.isNotEmpty) {
        final rawTopics =
            await (_db.select(_db.topics)
              ..where((t) => t.id.isIn(topicIds))).get();
        topics =
            rawTopics
                .map(
                  (t) => PlanningTopic(
                    id: t.id,
                    name: t.name,
                    description: t.description,
                    difficulty: t.difficulty,
                    estimatedMinutes: t.estimatedMinutes,
                    prerequisites:
                        t.prerequisites != null && t.prerequisites!.isNotEmpty
                            ? (() {
                              try {
                                return (jsonDecode(t.prerequisites!) as List)
                                    .map((e) => (e as num).toInt())
                                    .toList();
                              } catch (_) {
                                return null;
                              }
                            })()
                            : null,
                  ),
                )
                .toList();
      }

      // If no topics from DB, create dummy topics from goal text
      if (topics.isEmpty) {
        for (final goal in goals) {
          topics.add(PlanningTopic(id: 0, name: goal, estimatedMinutes: 60));
        }
      }

      final plan = _engine.buildStudyPlan(
        topics: topics,
        goals: goals,
        startDate: startDate,
        endDate: endDate,
        hoursPerWeek: hoursPerWeek,
        name: name,
        description: 'AI-generated study plan',
      );

      // Insert the plan
      final insertedPlan = await _db
          .into(_db.studyPlans)
          .insert(
            StudyPlansCompanion(
              name: Value(plan.name),
              description: Value(plan.description),
              startDate: Value(plan.startDate),
              endDate: Value(plan.endDate),
              goals: Value(jsonEncode(plan.goals)),
              targetHoursPerWeek: Value(plan.targetHoursPerWeek),
              isActive: Value(true),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // Insert plan items
      for (final item in plan.items) {
        await _db
            .into(_db.studyPlanItems)
            .insert(
              StudyPlanItemsCompanion(
                planId: Value(insertedPlan),
                topicId:
                    item.topicId != null && item.topicId! > 0
                        ? Value(item.topicId!)
                        : const Value.absent(),
                resourceId: const Value.absent(),
                title: Value(item.title),
                type: Value(item.type),
                estimatedMinutes: Value(item.estimatedMinutes),
                orderIndex: Value(item.orderIndex),
                scheduledDate: Value(item.scheduledDate),
                isCompleted: const Value(false),
                createdAt: Value(DateTime.now()),
              ),
            );
      }

      // Check if AI is available to enrich the plan with descriptions
      try {
        await _aiEnrichPlan(insertedPlan, plan.name, goals);
      } catch (_) {
        // AI enrichment is optional
      }

      await _loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _aiEnrichPlan(
    int planId,
    String name,
    List<String> goals,
  ) async {
    final prompt = '''<<SYS>>
You are a study planner assistant. Generate a brief motivational study plan summary.
Keep it under 100 words.

Plan: $name
Goals: ${goals.join(', ')}
<</SYS>>

<<USER>>
Generate a motivational summary for this study plan.
</USER>>

<<ASSISTANT>>
''';

    final buffer = StringBuffer();
    await for (final chunk in _aiEngine.generate(
      prompt: prompt,
      history: [],
      maxTokens: 128,
      temperature: 0.7,
    )) {
      buffer.write(chunk);
    }

    final summary = buffer.toString().trim();
    if (summary.isNotEmpty) {
      await (_db.update(_db.studyPlans)..where(
        (t) => t.id.equals(planId),
      )).write(StudyPlansCompanion(description: Value(summary)));
    }
  }

  Future<void> deletePlan(int planId) async {
    await (_db.delete(_db.studyPlanItems)
      ..where((t) => t.planId.equals(planId))).go();
    await (_db.delete(_db.studyPlans)..where((t) => t.id.equals(planId))).go();
    await _loadAll();
  }

  Future<void> togglePlanActive(int planId) async {
    final plan = state.plans.firstWhere(
      (p) => p.id == planId,
      orElse: () => throw Exception('Plan not found'),
    );
    await (_db.update(_db.studyPlans)..where((t) => t.id.equals(planId))).write(
      StudyPlansCompanion(
        isActive: Value(!plan.isActive),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _loadAll();
  }

  // ── Item Operations ───────────────────────────────────────────────

  /// Mark a plan item as completed and record a study session.
  Future<void> completeItem(int planItemId, {int? durationMinutes}) async {
    final item = state.items.firstWhere(
      (i) => i.id == planItemId,
      orElse: () => throw Exception('Item not found'),
    );

    final now = DateTime.now();
    final actualDuration = durationMinutes ?? item.estimatedMinutes;

    // Mark item as completed
    await (_db.update(_db.studyPlanItems)
      ..where((t) => t.id.equals(planItemId))).write(
      StudyPlanItemsCompanion(
        isCompleted: Value(true),
        completedAt: Value(now),
      ),
    );

    // Record study session
    final planItem =
        await (_db.select(_db.studyPlanItems)
          ..where((t) => t.id.equals(planItemId))).getSingleOrNull();

    if (planItem != null) {
      final sessionStart = now.subtract(Duration(minutes: actualDuration));
      await _db
          .into(_db.studySessions)
          .insert(
            StudySessionsCompanion(
              planId: Value(planItem.planId),
              planItemId: Value(planItemId),
              topicId:
                  planItem.topicId != null
                      ? Value(planItem.topicId!)
                      : const Value.absent(),
              activityType: Value(item.type),
              durationMinutes: Value(actualDuration),
              startedAt: Value(sessionStart),
              endedAt: Value(now),
            ),
          );
    }

    await _refreshItems();
    await _refreshTodayItems();
    await _refreshSessions();
  }

  /// Start a study session for a plan item.
  Future<int> startSession({
    required int planItemId,
    required String activityType,
  }) async {
    final planItem =
        await (_db.select(_db.studyPlanItems)
          ..where((t) => t.id.equals(planItemId))).getSingleOrNull();

    if (planItem == null) return -1;

    final now = DateTime.now();
    final session = await _db
        .into(_db.studySessions)
        .insert(
          StudySessionsCompanion(
            planId: Value(planItem.planId),
            planItemId: Value(planItemId),
            topicId:
                planItem.topicId != null
                    ? Value(planItem.topicId!)
                    : const Value.absent(),
            activityType: Value(activityType),
            durationMinutes: Value(0),
            startedAt: Value(now),
            endedAt: Value(now),
          ),
        );

    await _refreshSessions();
    return session;
  }

  /// Stop an active study session.
  Future<void> stopSession({
    required int sessionId,
    required int durationMinutes,
    int? focusScore,
    String? notes,
  }) async {
    final now = DateTime.now();
    final companion = StudySessionsCompanion(
      durationMinutes: Value(durationMinutes),
      endedAt: Value(now),
      focusScore: focusScore != null ? Value(focusScore) : const Value.absent(),
      notes: notes != null ? Value(notes) : const Value.absent(),
    );

    await (_db.update(_db.studySessions)
      ..where((t) => t.id.equals(sessionId))).write(companion);

    await _refreshSessions();
  }

  /// Reschedule missed items for a plan.
  Future<void> rescheduleMissed(int planId) async {
    // Fetch plan data
    final planRow =
        await (_db.select(_db.studyPlans)
          ..where((t) => t.id.equals(planId))).getSingleOrNull();
    if (planRow == null) return;

    final planItems =
        await (_db.select(_db.studyPlanItems)
              ..where(
                (t) => t.planId.equals(planId) & t.isCompleted.equals(false),
              )
              ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
            .get();

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    // Find overdue items
    final overdueItems =
        planItems.where((i) => i.scheduledDate!.isBefore(today)).toList();

    if (overdueItems.isEmpty) return;

    // Reschedule overdue items to upcoming days
    int dayOffset = 1;
    for (final item in overdueItems) {
      final newDate = today.add(Duration(days: dayOffset));
      await (_db.update(_db.studyPlanItems)..where(
        (t) => t.id.equals(item.id),
      )).write(StudyPlanItemsCompanion(scheduledDate: Value(newDate)));
      dayOffset = (dayOffset % 5) + 1; // Spread across weekdays
    }

    await _loadAll();
  }

  // ── AI-Generated Plans ────────────────────────────────────────────

  /// Generate a plan from an exam schedule.
  Future<void> generatePlanFromExam(int examScheduleId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final examRow =
          await (_db.select(_db.examSchedules)
            ..where((t) => t.id.equals(examScheduleId))).getSingleOrNull();
      if (examRow == null) {
        state = state.copyWith(isLoading: false, error: 'Exam not found');
        return;
      }

      final exam = PlanningExam.fromTable(examRow);

      // Fetch relevant topics
      List<PlanningTopic> topics = [];
      if (exam.topicIds != null && exam.topicIds!.isNotEmpty) {
        final rawTopics =
            await (_db.select(_db.topics)
              ..where((t) => t.id.isIn(exam.topicIds!))).get();
        topics =
            rawTopics
                .map(
                  (t) => PlanningTopic(
                    id: t.id,
                    name: t.name,
                    description: t.description,
                    difficulty: t.difficulty,
                    estimatedMinutes: t.estimatedMinutes,
                  ),
                )
                .toList();
      }

      final plan = _engine.optimizeForExam(exam: exam, topics: topics);

      // Insert the plan
      final insertedPlan = await _db
          .into(_db.studyPlans)
          .insert(
            StudyPlansCompanion(
              name: Value(plan.name),
              description: Value(plan.description),
              startDate: Value(plan.startDate),
              endDate: Value(plan.endDate),
              goals: Value(jsonEncode(plan.goals)),
              targetHoursPerWeek: Value(plan.targetHoursPerWeek),
              isActive: Value(true),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );

      for (final item in plan.items) {
        await _db
            .into(_db.studyPlanItems)
            .insert(
              StudyPlanItemsCompanion(
                planId: Value(insertedPlan),
                topicId:
                    item.topicId != null && item.topicId! > 0
                        ? Value(item.topicId!)
                        : const Value.absent(),
                resourceId: const Value.absent(),
                title: Value(item.title),
                type: Value(item.type),
                estimatedMinutes: Value(item.estimatedMinutes),
                orderIndex: Value(item.orderIndex),
                scheduledDate: Value(item.scheduledDate),
                isCompleted: const Value(false),
                createdAt: Value(DateTime.now()),
              ),
            );
      }

      await _loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Generate a focused plan for a single topic.
  Future<void> generatePlanFromTopic({
    required int topicId,
    required String goal,
    required int days,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final topicRow =
          await (_db.select(_db.topics)
            ..where((t) => t.id.equals(topicId))).getSingleOrNull();
      if (topicRow == null) {
        state = state.copyWith(isLoading: false, error: 'Topic not found');
        return;
      }

      final topic = PlanningTopic(
        id: topicRow.id,
        name: topicRow.name,
        description: topicRow.description,
        difficulty: topicRow.difficulty,
        estimatedMinutes: topicRow.estimatedMinutes,
      );

      final endDate = DateTime.now().add(Duration(days: days));

      final plan = _engine.buildStudyPlan(
        topics: [topic],
        goals: [goal],
        startDate: DateTime.now(),
        endDate: endDate,
        hoursPerWeek: days > 0 ? 10 : 10,
        name: '$topic - $goal',
      );

      final insertedPlan = await _db
          .into(_db.studyPlans)
          .insert(
            StudyPlansCompanion(
              name: Value(plan.name),
              description: Value(plan.description),
              startDate: Value(plan.startDate),
              endDate: Value(plan.endDate),
              goals: Value(jsonEncode(plan.goals)),
              targetHoursPerWeek: Value(plan.targetHoursPerWeek),
              isActive: Value(true),
              createdAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );

      for (final item in plan.items) {
        await _db
            .into(_db.studyPlanItems)
            .insert(
              StudyPlanItemsCompanion(
                planId: Value(insertedPlan),
                topicId:
                    item.topicId != null && item.topicId! > 0
                        ? Value(item.topicId!)
                        : const Value.absent(),
                resourceId: const Value.absent(),
                title: Value(item.title),
                type: Value(item.type),
                estimatedMinutes: Value(item.estimatedMinutes),
                orderIndex: Value(item.orderIndex),
                scheduledDate: Value(item.scheduledDate),
                isCompleted: const Value(false),
                createdAt: Value(DateTime.now()),
              ),
            );
      }

      await _loadAll();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ── Refresh ───────────────────────────────────────────────────────

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    await _loadAll();
    state = state.copyWith(isLoading: false);
  }
}
