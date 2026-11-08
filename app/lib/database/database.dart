import 'package:drift/drift.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter/sqlite3_flutter.dart';

import 'tables/conversations.dart';
import 'tables/messages.dart';
import 'tables/notes.dart';
import 'tables/other_tables.dart';

part 'database.g.dart';

/// Local SQLite database for InhaleSkill AI.
/// All data persists on-device. No cloud sync.
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
class AppDatabase extends_$AppDatabase {
  AppDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      sqlite3Flutter.install();
      final db = sqlite3.open('inhaleskill_ai.db');
      return DatabaseConnection.fromDb(db);
    });
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
          if (from < 3) {
            await migrator.createIndex(Index(
              'idx_messages_conversation',
              messages,
              [messages.conversationId],
            ));
            await migrator.createIndex(Index(
              'idx_notes_subject',
              notes,
              [notes.subject],
            ));
          }
        },
        beforeOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );
}
