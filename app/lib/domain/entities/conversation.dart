/// Conversation entity for the domain layer.
class Conversation {
  final int? id;
  final String title;
  final String? mode;
  final String? context;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final int messageCount;

  const Conversation({
    this.id,
    required this.title,
    this.mode,
    this.context,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.messageCount = 0,
  });

  Conversation copyWith({
    int? id,
    String? title,
    String? mode,
    String? context,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    int? messageCount,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      mode: mode ?? this.mode,
      context: context ?? this.context,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}
