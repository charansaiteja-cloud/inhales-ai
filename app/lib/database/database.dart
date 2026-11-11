import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

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
    // Phase 22: Study Platform Tables
    Subjects,
    Chapters,
    Topics,
    LearningResources,
    FlashcardDecks,
    Flashcards,
    FlashcardReviews,
    StudyPlans,
    StudyPlanItems,
    StudySessions,
    ExamSchedules,
    Achievements,
    UserAchievements,
    Notifications,
    Recommendations,
    MindMaps,
    VideoTranscripts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    final appDir = Directory.current;
    final dbPath = p.join(appDir.path, 'databases', 'inhaleskill_ai.db');
    return NativeDatabase(
      File(dbPath),
      setup: (db) => db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  @override
  int get schemaVersion => 6;

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
        if (from < 6) {
          // Phase 22: Study Platform Tables
          await migrator.createTable(db.subjects);
          await migrator.createTable(db.chapters);
          await migrator.createTable(db.topics);
          await migrator.createTable(db.learningResources);
          await migrator.createTable(db.flashcardDecks);
          await migrator.createTable(db.flashcards);
          await migrator.createTable(db.flashcardReviews);
          await migrator.createTable(db.studyPlans);
          await migrator.createTable(db.studyPlanItems);
          await migrator.createTable(db.studySessions);
          await migrator.createTable(db.examSchedules);
          await migrator.createTable(db.achievements);
          await migrator.createTable(db.userAchievements);
          await migrator.createTable(db.notifications);
          await migrator.createTable(db.recommendations);
          await migrator.createTable(db.mindMaps);
          await migrator.createTable(db.videoTranscripts);
        }
      },
    );
  }
}
