// Drift implementation of MessageRepository.
import 'package:drift/drift.dart';
import '../../../database/database.dart' as db;
import '../../domain/entities/message.dart' as domain;
import '../../domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final db.AppDatabase _database;

  MessageRepositoryImpl(this._database);

  domain.Message _mapToEntity(db.Message data) {
    return domain.Message(
      id: data.id,
      conversationId: data.conversationId,
      role: data.role,
      content: data.content,
      createdAt: data.createdAt,
      isEdited: data.isEdited,
      isBookmarked: data.isBookmarked,
      tokenCount: data.tokenCount,
    );
  }

  @override
  Future<List<domain.Message>> getByConversation(int conversationId) async {
    final query =
        _database.select(_database.messages)
          ..where((m) => m.conversationId.equals(conversationId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]);
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<domain.Message> create(domain.Message message) async {
    final companion = db.MessagesCompanion(
      conversationId: Value(message.conversationId),
      role: Value(message.role),
      content: Value(message.content),
      createdAt: Value(message.createdAt),
      isEdited: Value(message.isEdited),
      isBookmarked: Value(message.isBookmarked),
      tokenCount: Value(message.tokenCount),
    );
    final id = await _database.into(_database.messages).insert(companion);
    return message.copyWith(id: id);
  }

  @override
  Future<domain.Message> update(domain.Message message) async {
    if (message.id == null) {
      throw ArgumentError('Cannot update message without ID');
    }
    final companion = db.MessagesCompanion(
      id: Value(message.id!),
      conversationId: Value(message.conversationId),
      role: Value(message.role),
      content: Value(message.content),
      isEdited: Value(message.isEdited),
      isBookmarked: Value(message.isBookmarked),
      tokenCount: Value(message.tokenCount),
    );
    await _database.update(_database.messages).replace(companion);
    return message;
  }

  @override
  Future<void> delete(int id) async {
    await (_database.delete(_database.messages)
      ..where((m) => m.id.equals(id))).go();
  }

  @override
  Future<void> toggleBookmark(int id) async {
    final message =
        await (_database.select(_database.messages)
          ..where((m) => m.id.equals(id))).getSingleOrNull();
    if (message != null) {
      await (_database.update(_database.messages)
        ..where((m) => m.id.equals(id))).write(
        db.MessagesCompanion(isBookmarked: Value(!message.isBookmarked)),
      );
    }
  }

  @override
  Future<List<domain.Message>> getBookmarked(int conversationId) async {
    final query =
        _database.select(_database.messages)
          ..where(
            (m) =>
                m.conversationId.equals(conversationId) &
                m.isBookmarked.equals(true),
          )
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }
}
