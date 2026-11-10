/// AI-powered study scheduling engine.
/// Generates and optimizes study plans based on topics, goals, and exam schedules.
library;

import 'dart:convert';
import '../../database/database.dart';

/// Represents a generated study plan item.
class StudyPlanItemData {
  final int? topicId;
  final int? resourceId;
  final String title;
  final String type; // 'read', 'video', 'quiz', 'flashcard', 'practice', 'review'
  final int estimatedMinutes;
  final int orderIndex;
  final DateTime scheduledDate;

  const StudyPlanItemData({
    this.topicId,
    this.resourceId,
    required this.title,
    required this.type,
    required this.estimatedMinutes,
    required this.orderIndex,
    required this.scheduledDate,
  });

  StudyPlanItemData copyWith({
    int? topicId,
    int? resourceId,
    String? title,
    String? type,
    int? estimatedMinutes,
    int? orderIndex,
    DateTime? scheduledDate,
  }) => StudyPlanItemData(
    topicId: topicId ?? this.topicId,
    resourceId: resourceId ?? this.resourceId,
    title: title ?? this.title,
    type: type ?? this.type,
    estimatedMinutes: estimatedMinutes ?? this.estimatedMinutes,
    orderIndex: orderIndex ?? this.orderIndex,
    scheduledDate: scheduledDate ?? this.scheduledDate,
  );
}

/// Represents a complete study plan with items.
class StudyPlanData {
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> goals;
  final int? targetHoursPerWeek;
  final Map<String, dynamic>? scheduleConfig;
  final List<StudyPlanItemData> items;

  const StudyPlanData({
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.goals,
    this.targetHoursPerWeek,
    this.scheduleConfig,
    this.items = const [],
  });

  StudyPlanData copyWith({
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? goals,
    int? targetHoursPerWeek,
    Map<String, dynamic>? scheduleConfig,
    List<StudyPlanItemData>? items,
  }) => StudyPlanData(
    name: name ?? this.name,
    description: description ?? this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    goals: goals ?? this.goals,
    targetHoursPerWeek: targetHoursPerWeek ?? this.targetHoursPerWeek,
    scheduleConfig: scheduleConfig ?? this.scheduleConfig,
    items: items ?? this.items,
  );
}

/// Topic data for planning.
class PlanningTopic {
  final int id;
  final String name;
  final String? description;
  final String? difficulty;
  final int? estimatedMinutes;
  final List<int>? prerequisites;

  const PlanningTopic({
    required this.id,
    required this.name,
    this.description,
    this.difficulty,
    this.estimatedMinutes,
    this.prerequisites,
  });

  factory PlanningTopic.fromTable(Topic topic) {
    List<int>? prereqs;
    if (topic.prerequisites != null && topic.prerequisites!.isNotEmpty) {
      try {
        final decoded = jsonDecode(topic.prerequisites!) as List;
        prereqs = decoded.map((e) => (e as num).toInt()).toList();
      } catch (_) {}
    }
    return PlanningTopic(
      id: topic.id,
      name: topic.name,
      description: topic.description,
      difficulty: topic.difficulty,
      estimatedMinutes: topic.estimatedMinutes,
      prerequisites: prereqs,
    );
  }
}

/// Exam data for planning.
class PlanningExam {
  final int id;
  final String name;
  final String? subject;
  final DateTime examDate;
  final List<int>? topicIds;
  final List<int>? resourceIds;
  final int? targetScore;

  const PlanningExam({
    required this.id,
    required this.name,
    this.subject,
    required this.examDate,
    this.topicIds,
    this.resourceIds,
    this.targetScore,
  });

  factory PlanningExam.fromTable(ExamSchedule exam) {
    List<int>? topicIds;
    List<int>? resourceIds;
    if (exam.topicsCovered != null && exam.topicsCovered!.isNotEmpty) {
      try {
        final decoded = jsonDecode(exam.topicsCovered!) as List;
        topicIds = decoded.map((e) => (e as num).toInt()).toList();
      } catch (_) {}
    }
    if (exam.resources != null && exam.resources!.isNotEmpty) {
      try {
        final decoded = jsonDecode(exam.resources!) as List;
        resourceIds = decoded.map((e) => (e as num).toInt()).toList();
      } catch (_) {}
    }
    return PlanningExam(
      id: exam.id,
      name: exam.name,
      subject: exam.subject,
      examDate: exam.examDate,
      topicIds: topicIds,
      resourceIds: resourceIds,
      targetScore: exam.targetScore,
    );
  }
}

/// AI-powered scheduling engine for study plans.
class SchedulingEngine {
  /// Build a study plan from topics and goals.
  /// Distributes items across days between startDate and endDate based on hoursPerWeek.
  StudyPlanData buildStudyPlan({
    required List<PlanningTopic> topics,
    required List<String> goals,
    required DateTime startDate,
    required DateTime endDate,
    required int hoursPerWeek,
    String? name,
    String? description,
    Map<String, dynamic>? scheduleConfig,
  }) {
    final now = DateTime.now();
    final effectiveStart = startDate.isAfter(now) ? startDate : now;
    final effectiveEnd = endDate.isBefore(effectiveStart)
        ? effectiveStart.add(const Duration(days: 7))
        : endDate;

    final totalDays = effectiveEnd.difference(effectiveStart).inDays + 1;
    final totalHours = (hoursPerWeek * totalDays) / 7.0;
    final totalMinutes = (totalHours * 60).round();

    // Calculate topic weights based on difficulty and estimated time
    final topicWeights = <int, double>{};
    double totalWeight = 0;

    for (final topic in topics) {
      double weight = 1.0;
      // Adjust weight by difficulty
      switch (topic.difficulty?.toLowerCase()) {
        case 'beginner':
          weight *= 0.8;
          break;
        case 'intermediate':
          weight *= 1.0;
          break;
        case 'advanced':
          weight *= 1.3;
          break;
        default:
          weight *= 1.0;
      }
      // Adjust by estimated time if available
      if (topic.estimatedMinutes != null && topic.estimatedMinutes! > 0) {
        weight *= (topic.estimatedMinutes! / 30.0);
      } else {
        weight *= 2.0; // Default 60 minutes per topic
      }
      topicWeights[topic.id] = weight;
      totalWeight += weight;
    }

    // Generate items distributed across days
    final items = <StudyPlanItemData>[];
    int itemIndex = 0;
    double allocatedMinutes = 0;

    // Sort topics by prerequisites first (topics with prereqs come later)
    final sortedTopics = List<PlanningTopic>.from(topics);
    sortedTopics.sort((a, b) {
      final aPrereqs = a.prerequisites?.length ?? 0;
      final bPrereqs = b.prerequisites?.length ?? 0;
      return aPrereqs.compareTo(bPrereqs);
    });

    for (final topic in sortedTopics) {
      final weight = topicWeights[topic.id] ?? 1.0;
      final topicMinutes = ((totalMinutes * weight) / totalWeight).round();

      if (topicMinutes < 10) continue; // Skip very small allocations

      // Break into sessions of 25-45 minutes (Pomodoro-style)
      final sessionsPerTopic = (topicMinutes / 35).ceil();
      final minutesPerSession = (topicMinutes / sessionsPerTopic).round();

      for (int i = 0; i < sessionsPerTopic; i++) {
        final dayOffset = itemIndex % totalDays;
        final scheduledDate = effectiveStart.add(Duration(days: dayOffset));

        // Cycle through activity types
        final activityTypes = ['read', 'practice', 'review', 'quiz', 'flashcard'];
        final activityType = activityTypes[itemIndex % activityTypes.length];

        items.add(StudyPlanItemData(
          topicId: topic.id,
          title: '${topic.name} - Session ${i + 1}',
          type: activityType,
          estimatedMinutes: minutesPerSession.clamp(25, 45),
          orderIndex: itemIndex,
          scheduledDate: scheduledDate,
        ));

        allocatedMinutes += minutesPerSession;
        itemIndex++;
      }
    }

    // Add review sessions at the end
    final reviewDate = effectiveEnd.subtract(const Duration(days: 1));
    if (reviewDate.isAfter(effectiveStart)) {
      items.add(StudyPlanItemData(
        title: 'Comprehensive Review',
        type: 'review',
        estimatedMinutes: 60,
        orderIndex: itemIndex,
        scheduledDate: reviewDate,
      ));
    }

    return StudyPlanData(
      name: name ?? 'Study Plan',
      description: description,
      startDate: effectiveStart,
      endDate: effectiveEnd,
      goals: goals,
      targetHoursPerWeek: hoursPerWeek,
      scheduleConfig: scheduleConfig,
      items: items,
    );
  }

  /// Reschedule a plan when items are missed.
  /// Pushes missed items forward and adjusts the schedule.
  StudyPlanData reschedule({
    required StudyPlanData plan,
    required List<int> missedItemIds,
    DateTime? fromDate,
  }) {
    final now = fromDate ?? DateTime.now();
    final items = List<StudyPlanItemData>.from(plan.items);

    // Find items that need rescheduling
    final missedItems = items.where((item) {
      if (missedItemIds.contains(item.orderIndex)) return true;
      if (item.scheduledDate.isBefore(now) &&
          item.type != 'review') return true;
      return false;
    }).toList();

    if (missedItems.isEmpty) return plan;

    // Calculate new end date if needed
    final totalMissedMinutes = missedItems.fold<int>(
      0,
      (sum, item) => sum + item.estimatedMinutes,
    );

    // Push items forward
    final remainingDays = plan.endDate.difference(now).inDays + 1;
    final availableMinutesPerDay =
        ((plan.targetHoursPerWeek ?? 10) * 60 / 7).round();
    final extraDaysNeeded = (totalMissedMinutes / availableMinutesPerDay).ceil();

    final newEndDate = plan.endDate.add(Duration(days: extraDaysNeeded));

    // Reschedule missed items
    int newItemIndex = items.length;
    for (final missedItem in missedItems) {
      final dayOffset = newItemIndex % (remainingDays + extraDaysNeeded);
      final newDate = now.add(Duration(days: dayOffset));

      final updatedItem = missedItem.copyWith(
        scheduledDate: newDate,
        orderIndex: newItemIndex,
      );

      items.remove(missedItem);
      items.add(updatedItem);
      newItemIndex++;
    }

    // Sort by scheduled date
    items.sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

    return plan.copyWith(
      endDate: newEndDate,
      items: items,
    );
  }

  /// Create a focused study plan leading up to an exam.
  StudyPlanData optimizeForExam({
    required PlanningExam exam,
    required List<PlanningTopic> topics,
    String? name,
    int? hoursPerDay,
  }) {
    final now = DateTime.now();
    final daysUntilExam = exam.examDate.difference(now).inDays;

    if (daysUntilExam <= 0) {
      // Exam is today or passed - create intensive same-day plan
      return _createIntensiveExamPlan(exam, topics, name);
    }

    // Filter topics relevant to the exam
    final relevantTopics = exam.topicIds != null && exam.topicIds!.isNotEmpty
        ? topics.where((t) => exam.topicIds!.contains(t.id)).toList()
        : topics;

    if (relevantTopics.isEmpty) {
      // No specific topics - create general review plan
      return _createGeneralExamPlan(exam, daysUntilExam, name);
    }

    // Prioritize topics by difficulty and exam relevance
    relevantTopics.sort((a, b) {
      final difficultyOrder = {'advanced': 0, 'intermediate': 1, 'beginner': 2};
      final aDiff = difficultyOrder[a.difficulty?.toLowerCase()] ?? 1;
      final bDiff = difficultyOrder[b.difficulty?.toLowerCase()] ?? 1;
      return aDiff.compareTo(bDiff);
    });

    final dailyHours = hoursPerDay ?? 4;
    final totalMinutes = (dailyHours * 60 * daysUntilExam).round();
    final minutesPerTopic = (totalMinutes / relevantTopics.length).round();

    final items = <StudyPlanItemData>[];
    int itemIndex = 0;

    for (final topic in relevantTopics) {
      final sessionsNeeded = (minutesPerTopic / 40).ceil();
      for (int i = 0; i < sessionsNeeded; i++) {
        final dayOffset = itemIndex ~/ 3; // 3 sessions per day max
        if (dayOffset >= daysUntilExam) break;

        final scheduledDate = now.add(Duration(days: dayOffset));
        final activityType = i == sessionsNeeded - 1 ? 'review' : 'practice';

        items.add(StudyPlanItemData(
          topicId: topic.id,
          title: '${topic.name} - Exam Prep ${i + 1}',
          type: activityType,
          estimatedMinutes: 40,
          orderIndex: itemIndex,
          scheduledDate: scheduledDate,
        ));
        itemIndex++;
      }
    }

    // Add final review day before exam
    final dayBeforeExam = exam.examDate.subtract(const Duration(days: 1));
    if (dayBeforeExam.isAfter(now)) {
      items.add(StudyPlanItemData(
        title: 'Final Exam Review - ${exam.name}',
        type: 'review',
        estimatedMinutes: 120,
        orderIndex: itemIndex,
        scheduledDate: dayBeforeExam,
      ));
    }

    return StudyPlanData(
      name: name ?? 'Exam Prep: ${exam.name}',
      description: 'Focused study plan for ${exam.name} on ${_formatDate(exam.examDate)}',
      startDate: now,
      endDate: exam.examDate.subtract(const Duration(days: 1)),
      goals: [
        'Complete all ${relevantTopics.length} topics',
        'Review key concepts',
        'Practice with sample questions',
        'Achieve ${exam.targetScore ?? 80}% target score',
      ],
      targetHoursPerWeek: dailyHours * 7,
      items: items,
    );
  }

  StudyPlanData _createIntensiveExamPlan(
    PlanningExam exam,
    List<PlanningTopic> topics,
    String? name,
  ) {
    final now = DateTime.now();
    final items = <StudyPlanItemData>[];

    for (int i = 0; i < topics.length && i < 5; i++) {
      items.add(StudyPlanItemData(
        topicId: topics[i].id,
        title: 'Rapid Review: ${topics[i].name}',
        type: 'review',
        estimatedMinutes: 30,
        orderIndex: i,
        scheduledDate: now.add(Duration(minutes: i * 45)),
      ));
    }

    return StudyPlanData(
      name: name ?? 'Last-Minute Exam Prep: ${exam.name}',
      description: 'Intensive review for exam today',
      startDate: now,
      endDate: exam.examDate,
      goals: ['Quick review of key topics'],
      targetHoursPerWeek: 20,
      items: items,
    );
  }

  StudyPlanData _createGeneralExamPlan(
    PlanningExam exam,
    int daysUntilExam,
    String? name,
  ) {
    final now = DateTime.now();
    final items = <StudyPlanItemData>[];

    for (int day = 0; day < daysUntilExam && day < 14; day++) {
      items.add(StudyPlanItemData(
        title: 'General Study Session ${day + 1}',
        type: day % 3 == 0 ? 'read' : day % 3 == 1 ? 'practice' : 'review',
        estimatedMinutes: 60,
        orderIndex: day,
        scheduledDate: now.add(Duration(days: day)),
      ));
    }

    return StudyPlanData(
      name: name ?? 'Exam Prep: ${exam.name}',
      description: 'General study plan for ${exam.name}',
      startDate: now,
      endDate: exam.examDate.subtract(const Duration(days: 1)),
      goals: ['Consistent daily study'],
      targetHoursPerWeek: 14,
      items: items,
    );
  }

  /// Calculate items scheduled for a specific date.
  List<StudyPlanItemData> calculateDailyLoad(
    StudyPlanData plan,
    DateTime date,
  ) {
    final targetDate = DateTime(date.year, date.month, date.day);
    return plan.items.where((item) {
      final itemDate = DateTime(
        item.scheduledDate.year,
        item.scheduledDate.month,
        item.scheduledDate.day,
      );
      return itemDate == targetDate;
    }).toList()
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  }

  /// Calculate items scheduled for a date range (e.g., a week).
  Map<DateTime, List<StudyPlanItemData>> calculateWeeklyLoad(
    StudyPlanData plan,
    DateTime startDate,
  ) {
    final endDate = startDate.add(const Duration(days: 6));
    final weeklyLoad = <DateTime, List<StudyPlanItemData>>{};

    // Initialize all days
    for (int i = 0; i < 7; i++) {
      weeklyLoad[startDate.add(Duration(days: i))] = [];
    }

    // Populate with items
    for (final item in plan.items) {
      final itemDate = DateTime(
        item.scheduledDate.year,
        item.scheduledDate.month,
        item.scheduledDate.day,
      );
      if (!itemDate.isBefore(startDate) && !itemDate.isAfter(endDate)) {
        weeklyLoad[itemDate] = [
          ...weeklyLoad[itemDate]!,
          item,
        ];
      }
    }

    // Sort items within each day
    for (final key in weeklyLoad.keys) {
      weeklyLoad[key]!.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    }

    return weeklyLoad;
  }

  /// Estimate completion percentage of a plan.
  double estimateCompletion(
    StudyPlanData plan, {
    required List<int> completedItemIndices,
  }) {
    if (plan.items.isEmpty) return 0.0;

    final completedCount = completedItemIndices.length;
    return (completedCount / plan.items.length) * 100;
  }

  /// Calculate projected completion date based on current pace.
  DateTime? calculateProjectedCompletion(
    StudyPlanData plan,
    DateTime startedAt,
    int completedCount,
  ) {
    if (completedCount == 0 || plan.items.isEmpty) return null;

    final now = DateTime.now();
    final daysElapsed = now.difference(startedAt).inDays;
    if (daysElapsed <= 0) return plan.endDate;

    final itemsPerDay = completedCount / daysElapsed;
    final remainingItems = plan.items.length - completedCount;
    final daysNeeded = (remainingItems / itemsPerDay).ceil();

    return now.add(Duration(days: daysNeeded));
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
