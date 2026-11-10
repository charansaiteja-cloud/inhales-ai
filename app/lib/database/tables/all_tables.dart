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
