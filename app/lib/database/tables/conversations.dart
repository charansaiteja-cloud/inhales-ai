import 'package:drift/drift.dart';

/// Conversations table.
/// Persists conversation sessions locally.
@Table(name: 'conversations')
class Conversations extends Table {
  @override
  String get sqlName => 'conversations';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withDefault(const Constant('New Conversation'))();
  TextColumn get mode => text().nullable()();
  TextColumn get context => text().nullable()();
  DateTimeColumn get createdAt => datetime()();
  DateTimeColumn get updatedAt => datetime()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  IntColumn get messageCount => integer().withDefault(const Constant(0))();
}