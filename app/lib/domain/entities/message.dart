/// Message entity for the domain layer.
class Message {
  final int? id;
  final int conversationId;
  final String role; // 'user', 'assistant', 'system'
  final String content;
  final DateTime createdAt;
  final bool isEdited;
  final bool isBookmarked;
  final int? tokenCount;

  const Message({
    this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.isEdited = false,
    this.isBookmarked = false,
    this.tokenCount,
  });

  Message copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    DateTime? createdAt,
    bool? isEdited,
    bool? isBookmarked,
    int? tokenCount,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isEdited: isEdited ?? this.isEdited,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      tokenCount: tokenCount ?? this.tokenCount,
    );
  }
}
