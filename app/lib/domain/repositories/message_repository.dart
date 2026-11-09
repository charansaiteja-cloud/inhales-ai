// Repository interface for Message persistence.
import '../entities/message.dart';

abstract class MessageRepository {
  /// Get all messages for a conversation.
  Future<List<Message>> getByConversation(int conversationId);

  /// Create a new message.
  Future<Message> create(Message message);

  /// Update a message.
  Future<Message> update(Message message);

  /// Delete a message.
  Future<void> delete(int id);

  /// Toggle bookmark on a message.
  Future<void> toggleBookmark(int id);

  /// Get bookmarked messages for a conversation.
  Future<List<Message>> getBookmarked(int conversationId);
}
