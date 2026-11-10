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
    Memories,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    final db = sqlite3.open('inhaleskill_ai.db');

    // Load sqlite-vec extension
    try {
      // sqlite-vec registers itself automatically on newer versions
      db.execute('SELECT vec_version()');
    } catch (e) {
      // Extension not available, will use fallback search
    }

    return NativeDatabase.opened(
      db,
      setup: (db) => db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    final db = this;
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(db.bookmarks);
          await migrator.createTable(db.quizHistory);
          await migrator.createTable(db.learningActivity);
          await migrator.createTable(db.appModels);
          await migrator.createTable(db.preferences);
          await migrator.createTable(db.documents);
        }
        if (from < 3) {
          // Previous migrations
        }
        if (from < 4) {
          // Vector table created by RAGService.initialize()
        }
        if (from < 5) {
          await migrator.createTable(db.memories);
        }
      },
    );
  }
}
