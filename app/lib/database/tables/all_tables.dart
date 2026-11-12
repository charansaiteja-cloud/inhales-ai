import 'package:drift/drift.dart';

/// All database tables for InhaleSkill AI.

class Conversations extends Table {
  @override
  String get tableName => 'conversations';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>
      text().withDefault(const Constant('New Conversation'))();
  TextColumn get mode => text().nullable()();
  TextColumn get context => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  IntColumn get messageCount => integer().withDefault(const Constant(0))();
}

class Messages extends Table {
  @override
  String get tableName => 'messages';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId =>
      integer().references(Conversations, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isEdited => boolean().withDefault(const Constant(false))();
  BoolColumn get isBookmarked => boolean().withDefault(const Constant(false))();
  IntColumn get tokenCount => integer().nullable()();
}

class Notes extends Table {
  @override
  String get tableName => 'notes';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get folder => text().nullable()();
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  TextColumn get tags => text().nullable()();
}

class Bookmarks extends Table {
  @override
  String get tableName => 'bookmarks';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId =>
      integer().references(Messages, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime()();
}

class QuizHistory extends Table {
  @override
  String get tableName => 'quiz_history';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  IntColumn get totalQuestions => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get score => integer()();
  IntColumn get durationSeconds => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

class LearningActivity extends Table {
  @override
  String get tableName => 'learning_activity';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get activityType => text()();
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  IntColumn get durationMinutes => integer()();
  DateTimeColumn get date => dateTime()();
}

class AppModels extends Table {
  @override
  String get tableName => 'models';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get filePath => text()();
  TextColumn get quantization => text().nullable()();
  IntColumn get sizeBytes => integer()();
  TextColumn get architecture => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get installedAt => dateTime()();
}

class Preferences extends Table {
  @override
  String get tableName => 'preferences';
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column<Object>> get primaryKey => {key};
}

class Documents extends Table {
  @override
  String get tableName => 'documents';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get filePath => text()();
  TextColumn get fileType => text()();
  IntColumn get sizeBytes => integer()();
  TextColumn get extractedText => text().nullable()();
  TextColumn get summary => text().nullable()();
  DateTimeColumn get importedAt => dateTime()();
}

/// Conversation memories for long-term context retention.
class Memories extends Table {
  @override
  String get tableName => 'memories';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId =>
      integer().references(Conversations, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()(); // 'summary', 'fact', 'preference', 'topic'
  TextColumn get content => text()();
  RealColumn get importance => real().withDefault(const Constant(0.5))();
  DateTimeColumn get createdAt => dateTime()();
}

// ════════════════════════════════════════════════════════════════════
// PHASE 22: Study Platform Tables (Schema v6+)
// ════════════════════════════════════════════════════════════════════

/// Subjects/Courses catalog for organizing study content.
class Subjects extends Table {
  @override
  String get tableName => 'subjects';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get color => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Chapters within subjects.
class Chapters extends Table {
  @override
  String get tableName => 'chapters';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get subjectId =>
      integer().references(Subjects, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  IntColumn get estimatedMinutes => integer().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_chapters_subject',
          'CREATE INDEX idx_chapters_subject ON chapters(subject_id)',
        ),
      }.toList();
}

/// Topics within chapters (granular learning units).
class Topics extends Table {
  @override
  String get tableName => 'topics';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chapterId =>
      integer().references(Chapters, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get difficulty =>
      text().nullable()(); // 'beginner', 'intermediate', 'advanced'
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  IntColumn get estimatedMinutes => integer().nullable()();
  TextColumn get prerequisites =>
      text().nullable()(); // JSON array of topic IDs
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_topics_chapter',
          'CREATE INDEX idx_topics_chapter ON topics(chapter_id)',
        ),
      }.toList();
}

/// Unified learning resources (documents, videos, links, notes) linked to topics.
class LearningResources extends Table {
  @override
  String get tableName => 'learning_resources';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.cascade)
      .nullable()();
  IntColumn get subjectId => integer()
      .references(Subjects, #id, onDelete: KeyAction.cascade)
      .nullable()();
  TextColumn get title => text()();
  TextColumn get type =>
      text()(); // 'document', 'video', 'link', 'note', 'quiz', 'flashcard_set'
  TextColumn get sourceUrl => text().nullable()();
  TextColumn get localPath => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get thumbnailUrl => text().nullable()();
  IntColumn get durationSeconds => integer().nullable()();
  TextColumn get tags => text().nullable()(); // JSON array
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  List<Index> get indexes => {
        Index(
          'idx_learning_resources_topic',
          'CREATE INDEX idx_learning_resources_topic ON learning_resources(topic_id)',
        ),
      }.toList();
}

/// Flashcard decks (collections of flashcards).
class FlashcardDecks extends Table {
  @override
  String get tableName => 'flashcard_decks';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get subjectId => integer()
      .references(Subjects, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get sourceDocumentId =>
      text().nullable()(); // Link to Documents table
  IntColumn get cardCount => integer().withDefault(const Constant(0))();
  BoolColumn get isPublic => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Individual flashcards with FSRS spaced repetition fields.
class Flashcards extends Table {
  @override
  String get tableName => 'flashcards';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deckId =>
      integer().references(FlashcardDecks, #id, onDelete: KeyAction.cascade)();
  TextColumn get front => text()(); // Question/prompt
  TextColumn get back => text()(); // Answer
  TextColumn get hint => text().nullable()();
  TextColumn get tags => text().nullable()(); // JSON array
  TextColumn get sourceChunkId =>
      text().nullable()(); // Citation link to RAG chunk
  // FSRS fields
  RealColumn get stability => real().withDefault(const Constant(0.0))(); // Days
  RealColumn get difficulty =>
      real().withDefault(const Constant(0.0))(); // 0-10
  IntColumn get elapsedDays => integer().withDefault(const Constant(0))();
  IntColumn get scheduledDays => integer().withDefault(const Constant(0))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get lastReviewed => dateTime().nullable()();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get lapseCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_flashcards_deck_due',
          'CREATE INDEX idx_flashcards_deck_due ON flashcards(deck_id, due_date)',
        ),
        Index(
          'idx_flashcards_due',
          'CREATE INDEX idx_flashcards_due ON flashcards(due_date)',
        ),
      }.toList();
}

/// Flashcard review history for FSRS algorithm.
class FlashcardReviews extends Table {
  @override
  String get tableName => 'flashcard_reviews';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get flashcardId =>
      integer().references(Flashcards, #id, onDelete: KeyAction.cascade)();
  IntColumn get rating => integer()(); // 1=Again, 2=Hard, 3=Good, 4=Easy
  RealColumn get stabilityBefore => real()();
  RealColumn get difficultyBefore => real()();
  RealColumn get stabilityAfter => real()();
  RealColumn get difficultyAfter => real()();
  IntColumn get elapsedDays => integer()();
  IntColumn get scheduledDays => integer()();
  DateTimeColumn get reviewedAt => dateTime()();
}

/// Study plans (AI-generated schedules).
class StudyPlans extends Table {
  @override
  String get tableName => 'study_plans';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get goals => text().nullable()(); // JSON array of goal strings
  IntColumn get targetHoursPerWeek => integer().nullable()();
  TextColumn get scheduleConfig =>
      text().nullable()(); // JSON: preferred days, hours, break config
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Study plan items (specific tasks within a plan).
class StudyPlanItems extends Table {
  @override
  String get tableName => 'study_plan_items';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId =>
      integer().references(StudyPlans, #id, onDelete: KeyAction.cascade)();
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.cascade)
      .nullable()();
  IntColumn get resourceId => integer()
      .references(LearningResources, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get title => text()();
  TextColumn get type =>
      text()(); // 'read', 'video', 'quiz', 'flashcard', 'practice', 'review'
  IntColumn get estimatedMinutes => integer()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  DateTimeColumn get scheduledDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_study_plan_items_plan',
          'CREATE INDEX idx_study_plan_items_plan ON study_plan_items(plan_id)',
        ),
      }.toList();
}

/// Study sessions (actual study time tracking).
class StudySessions extends Table {
  @override
  String get tableName => 'study_sessions';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer()
      .references(StudyPlans, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get planItemId => integer()
      .references(StudyPlanItems, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get activityType =>
      text()(); // 'reading', 'video', 'quiz', 'flashcard', 'practice', 'review'
  IntColumn get durationMinutes => integer()();
  IntColumn get focusScore => integer().nullable()(); // 1-10 self-rated focus
  TextColumn get notes => text().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_study_sessions_date',
          'CREATE INDEX idx_study_sessions_date ON study_sessions(started_at)',
        ),
      }.toList();
}

/// Exam schedules and configuration.
class ExamSchedules extends Table {
  @override
  String get tableName => 'exam_schedules';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get subject => text().nullable()();
  TextColumn get examType => text()
      .nullable()(); // 'midterm', 'final', 'quiz', 'certification', 'custom'
  DateTimeColumn get examDate => dateTime()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get topicsCovered =>
      text().nullable()(); // JSON array of topic IDs
  TextColumn get resources => text().nullable()(); // JSON array of resource IDs
  IntColumn get targetScore => integer().nullable()(); // Percentage
  TextColumn get notes => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get actualScore => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Achievements/Gamification badges.
class Achievements extends Table {
  @override
  String get tableName => 'achievements';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key =>
      text()(); // Unique identifier: 'streak_7', 'quiz_master_100', etc.
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get icon => text().nullable()();
  TextColumn get category =>
      text()(); // 'streak', 'quiz', 'flashcard', 'study_time', 'completion', 'social'
  IntColumn get tier => integer().withDefault(
        const Constant(1),
      )(); // 1=bronze, 2=silver, 3=gold, 4=platinum
  IntColumn get xpReward => integer().withDefault(const Constant(0))();
  TextColumn get criteria => text().nullable()(); // JSON: conditions to unlock
  BoolColumn get isSecret => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}

/// User achievement progress/unlocks.
class UserAchievements extends Table {
  @override
  String get tableName => 'user_achievements';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get achievementId =>
      integer().references(Achievements, #id, onDelete: KeyAction.cascade)();
  IntColumn get progress =>
      integer().withDefault(const Constant(0))(); // Current progress
  IntColumn get target =>
      integer().withDefault(const Constant(1))(); // Target for unlock
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_user_achievements_unlocked',
          'CREATE INDEX idx_user_achievements_unlocked ON user_achievements(is_unlocked)',
        ),
      }.toList();
}

/// Notifications and reminders.
class Notifications extends Table {
  @override
  String get tableName => 'notifications';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type =>
      text()(); // 'study_reminder', 'exam_approaching', 'streak_risk', 'achievement', 'review_due', 'plan_due'
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get payload => text().nullable()(); // JSON: deep link data
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get scheduledFor => dateTime().nullable()();
  DateTimeColumn get readAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_notifications_scheduled',
          'CREATE INDEX idx_notifications_scheduled ON notifications(scheduled_for)',
        ),
      }.toList();
}

/// AI-generated recommendations.
class Recommendations extends Table {
  @override
  String get tableName => 'recommendations';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type =>
      text()(); // 'topic', 'resource', 'quiz', 'flashcard', 'review', 'schedule'
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get reason => text()(); // Why this was recommended
  IntColumn get priority =>
      integer().withDefault(const Constant(1))(); // 1=high, 2=medium, 3=low
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get resourceId => integer()
      .references(LearningResources, #id, onDelete: KeyAction.setNull)
      .nullable()();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();
  BoolColumn get isAccepted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  List<Index> get indexes => {
        Index(
          'idx_recommendations_topic',
          'CREATE INDEX idx_recommendations_topic ON recommendations(topic_id)',
        ),
      }.toList();
}

/// Mind maps for visual learning.
class MindMaps extends Table {
  @override
  String get tableName => 'mind_maps';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  IntColumn get topicId => integer()
      .references(Topics, #id, onDelete: KeyAction.setNull)
      .nullable()();
  IntColumn get subjectId => integer()
      .references(Subjects, #id, onDelete: KeyAction.setNull)
      .nullable()();
  TextColumn get data =>
      text()(); // JSON: nodes and edges for graph visualization
  TextColumn get layout =>
      text().nullable()(); // 'radial', 'hierarchical', 'force-directed'
  BoolColumn get isAiGenerated =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Video transcripts for video learning assistant.
class VideoTranscripts extends Table {
  @override
  String get tableName => 'video_transcripts';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get resourceId => integer().references(
        LearningResources,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get language => text().withDefault(const Constant('en'))();
  TextColumn get fullText => text()(); // Full transcript
  TextColumn get segments => text()(); // JSON: [{start, end, text}, ...]
  TextColumn get summary => text().nullable()();
  TextColumn get keyTopics => text().nullable()(); // JSON array
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
