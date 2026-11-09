// Repository interface for Conversation persistence.
import '../entities/conversation.dart';

abstract class ConversationRepository {
  /// Get all conversations, optionally filtered by mode.
  Future<List<Conversation>> getAll({String? mode});

  /// Get a conversation by ID.
  Future<Conversation?> getById(int id);

  /// Create a new conversation.
  Future<Conversation> create(Conversation conversation);

  /// Update an existing conversation.
  Future<Conversation> update(Conversation conversation);

  /// Delete a conversation.
  Future<void> delete(int id);

  /// Pin/unpin a conversation.
  Future<void> setPinned(int id, bool pinned);

  /// Get pinned conversations.
  Future<List<Conversation>> getPinned();

  /// Search conversations by title.
  Future<List<Conversation>> search(String query);
}
