// Drift implementation of ConversationRepository.
import 'package:drift/drift.dart';
import '../../database/database.dart' as db;
import '../../domain/entities/conversation.dart' as domain;
import '../../domain/repositories/conversation_repository.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final db.AppDatabase _database;

  ConversationRepositoryImpl(this._database);

  domain.Conversation _mapToEntity(db.Conversation data) {
    return domain.Conversation(
      id: data.id,
      title: data.title,
      mode: data.mode,
      context: data.context,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      isPinned: data.isPinned,
      messageCount: data.messageCount,
    );
  }

  @override
  Future<List<domain.Conversation>> getAll({
    String? mode,
    int? limit,
    int? offset,
  }) async {
    final query = _database.select(_database.conversations);
    if (mode != null) {
      query.where((c) => c.mode.equals(mode));
    }
    query.orderBy([(c) => OrderingTerm.desc(c.updatedAt)]);
    if (limit != null) {
      query.limit(limit, offset: offset);
    }
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<domain.Conversation?> getById(int id) async {
    final query = _database.select(_database.conversations)
      ..where((c) => c.id.equals(id));
    final result = await query.getSingleOrNull();
    return result != null ? _mapToEntity(result) : null;
  }

  @override
  Future<domain.Conversation> create(domain.Conversation conversation) async {
    final companion = db.ConversationsCompanion(
      title: Value(conversation.title),
      mode: Value(conversation.mode),
      context: Value(conversation.context),
      createdAt: Value(conversation.createdAt),
      updatedAt: Value(conversation.updatedAt),
      isPinned: Value(conversation.isPinned),
      messageCount: Value(conversation.messageCount),
    );
    final id = await _database.into(_database.conversations).insert(companion);
    return conversation.copyWith(id: id);
  }

  @override
  Future<domain.Conversation> update(domain.Conversation conversation) async {
    if (conversation.id == null) {
      throw ArgumentError('Cannot update conversation without ID');
    }
    final companion = db.ConversationsCompanion(
      id: Value(conversation.id!),
      title: Value(conversation.title),
      mode: Value(conversation.mode),
      context: Value(conversation.context),
      updatedAt: Value(conversation.updatedAt),
      isPinned: Value(conversation.isPinned),
      messageCount: Value(conversation.messageCount),
    );
    await _database.update(_database.conversations).replace(companion);
    return conversation;
  }

  @override
  Future<void> delete(int id) async {
    await (_database.delete(_database.conversations)
          ..where((c) => c.id.equals(id)))
        .go();
  }

  @override
  Future<void> setPinned(int id, bool pinned) async {
    await (_database.update(_database.conversations)
          ..where(
            (c) => c.id.equals(id),
          ))
        .write(db.ConversationsCompanion(isPinned: Value(pinned)));
  }

  @override
  Future<List<domain.Conversation>> getPinned() async {
    final query = _database.select(_database.conversations)
      ..where((c) => c.isPinned.equals(true))
      ..orderBy([(c) => OrderingTerm.desc(c.updatedAt)]);
    final results = await query.get();
    return results.map(_mapToEntity).toList();
  }

  @override
  Future<List<domain.Conversation>> search(String query) async {
    final results = await (_database.select(_database.conversations)
          ..where((c) => c.title.like('%$query%')))
        .get();
    return results.map(_mapToEntity).toList();
  }
}
