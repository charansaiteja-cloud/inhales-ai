import 'package:drift/drift.dart';

/// User notes — manual and AI-generated study notes.
@Table(name: 'notes')
class Notes extends Table {
  @override
  String get sqlName => 'notes';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get folder => text().nullable()();
  TextColumn get subject => text().nullable()();
  TextColumn get classLevel => text().nullable()();
  DateTimeColumn get createdAt => datetime()();
  DateTimeColumn get updatedAt => datetime()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  TextColumn get tags => text().nullable()();
}