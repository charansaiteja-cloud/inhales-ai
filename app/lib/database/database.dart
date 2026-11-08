import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';

import 'tables/all_tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Conversations,
    Messages,
    Notes,
    Bookmarks,
    QuizHistory,
    LearningActivity,
    AppModels,
    Preferences,
    Documents,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    final db = sqlite3.open('inhaleskill_ai.db');
    return NativeDatabase.opened(
      db,
      setup: (db) => db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(bookmarks);
        await migrator.createTable(quizHistory);
        await migrator.createTable(learningActivity);
        await migrator.createTable(appModels);
        await migrator.createTable(preferences);
        await migrator.createTable(documents);
      }
    },
  );
}
