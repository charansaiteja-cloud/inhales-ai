import 'package:drift/drift.dart';

/// Messages table — individual chat turns within a conversation.
@Table
class Messages extends Table {
  @override
  String get sqlName => 'messages';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get conversationId =>
      integer().references(Conversations, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text()(); // user | assistant | system
  TextColumn get content => text()();
  DateTimeColumn get createdAt => datetime()();
  BoolColumn get isEdited => boolean().withDefault(const Constant(false))();
  BoolColumn get isBookmarked => boolean().withDefault(const Constant(false))();
  IntColumn get tokenCount => integer().nullable()();
}