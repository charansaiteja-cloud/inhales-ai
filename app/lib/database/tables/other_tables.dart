import 'package:drift/drift.dart';

/// Bookmarks — saved important responses.
@Table(name: 'bookmarks')
class Bookmarks extends Table {
  @override
  String get sqlName => 'bookmarks';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId =>
      integer().references(Messages, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => datetime()();
}

/// Quiz history — past quiz attempts.
@Table(name: 'quiz_history')
class QuizHistory extends Table {
  @override
  String get sqlName => 'quiz_history';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  IntColumn get totalQuestions => integer()();
  IntColumn get correctAnswers => integer()();
  IntColumn get score => integer()();
  IntColumn get durationSeconds => integer()();
  DateTimeColumn get createdAt => datetime()();
}

/// Learning activity — daily progress tracking.
@Table(name: 'learning_activity')
class LearningActivity extends Table {
  @override
  String get sqlName => 'learning_activity';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get activityType => text()(); // chat, quiz, note, document, etc.
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  IntColumn get durationMinutes => integer()();
  DateTimeColumn get date => datetime()();
}

/// Model metadata — installed AI models.
@Table(name: 'models')
class AppModels extends Table {
  @override
  String get sqlName => 'models';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get filePath => text()();
  TextColumn get quantization => text().nullable()();
  IntColumn get sizeBytes => integer()();
  TextColumn get architecture => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  DateTimeColumn get installedAt => datetime()();
}

/// User preferences — key-value settings store.
@Table(name: 'preferences')
class Preferences extends Table {
  @override
  String get sqlName => 'preferences';

  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<String> get primaryKeys => {key};
}

/// Documents — imported files metadata.
@Table(name: 'documents')
class Documents extends Table {
  @override
  String get sqlName => 'documents';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get filePath => text()();
  TextColumn get fileType => text()(); // pdf, docx, txt, md
  IntColumn get sizeBytes => integer()();
  TextColumn get extractedText => text().nullable()();
  TextColumn get summary => text().nullable()();
  DateTimeColumn get importedAt => datetime()();
}