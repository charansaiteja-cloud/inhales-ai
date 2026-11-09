import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/conversation.dart' as domain;
import '../../../domain/entities/message.dart' as domain_msg;
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../di/di.dart';

/// Chat state model - UI-facing (maintains backward compatibility).
class ChatMessage {
  final int id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
  final bool isStreaming;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
    this.isStreaming = false,
  });

  /// Create from domain Message entity.
  factory ChatMessage.fromEntity(domain_msg.Message message) {
    return ChatMessage(
      id: message.id ?? 0,
      content: message.content,
      isUser: message.role == 'user',
      timestamp: message.createdAt,
      isStreaming: false,
    );
  }
}

class ChatSession {
  final int id;
  final String title;
  final List<ChatMessage> messages;
  final String mode;
  final DateTime lastMessageTime;

  const ChatSession({
    required this.id,
    required this.title,
    this.messages = const [],
    this.mode = 'chat',
    required this.lastMessageTime,
  });

  /// Create from domain Conversation and its Messages.
  factory ChatSession.fromEntities(
    domain.Conversation conversation,
    List<domain_msg.Message> messages,
  ) {
    return ChatSession(
      id: conversation.id ?? 0,
      title: conversation.title,
      messages: messages.map(ChatMessage.fromEntity).toList(),
      mode: conversation.mode ?? 'chat',
      lastMessageTime: conversation.updatedAt,
    );
  }
}

class ChatState {
  final List<ChatSession> sessions;
  final ChatSession? activeSession;
  final bool isGenerating;
  final String generationError;

  const ChatState({
    this.sessions = const [],
    this.activeSession,
    this.isGenerating = false,
    this.generationError = '',
  });

  ChatState copyWith({
    List<ChatSession>? sessions,
    ChatSession? activeSession,
    bool? isGenerating,
    String? generationError,
  }) => ChatState(
    sessions: sessions ?? this.sessions,
    activeSession: activeSession ?? this.activeSession,
    isGenerating: isGenerating ?? this.isGenerating,
    generationError: generationError ?? this.generationError,
  );
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final conversationRepo = ref.watch(conversationRepositoryProvider);
  final messageRepo = ref.watch(messageRepositoryProvider);
  return ChatNotifier(
    conversationRepository: conversationRepo,
    messageRepository: messageRepo,
  );
});

class ChatNotifier extends StateNotifier<ChatState> {
  final ConversationRepository _conversationRepository;
  final MessageRepository _messageRepository;
  int _nextId = 1;

  ChatNotifier({
    required ConversationRepository conversationRepository,
    required MessageRepository messageRepository,
  }) : _conversationRepository = conversationRepository,
       _messageRepository = messageRepository,
       super(const ChatState()) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    try {
      final conversations = await _conversationRepository.getAll();
      final sessions = <ChatSession>[];
      for (final conv in conversations) {
        final messages = await _messageRepository.getByConversation(conv.id!);
        sessions.add(ChatSession.fromEntities(conv, messages));
      }
      state = state.copyWith(
        sessions: sessions,
        activeSession: sessions.isNotEmpty ? sessions.first : null,
      );
    } catch (e) {
      state = state.copyWith(generationError: 'Failed to load sessions: $e');
    }
  }

  Future<ChatSession> newSession({String? mode}) async {
    final conversation = domain.Conversation(
      title: 'New Conversation',
      mode: mode ?? 'chat',
      context: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final saved = await _conversationRepository.create(conversation);
    final session = ChatSession(
      id: saved.id!,
      title: saved.title,
      mode: saved.mode ?? 'chat',
      lastMessageTime: saved.updatedAt,
    );

    state = ChatState(
      sessions: [session, ...state.sessions],
      activeSession: session,
    );
    return session;
  }

  Future<void> switchSession(ChatSession session) async {
    state = state.copyWith(activeSession: session);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.activeSession == null) return;

    final session = state.activeSession!;

    // Save user message to database
    final userMessageEntity = domain_msg.Message(
      conversationId: session.id,
      role: 'user',
      content: text.trim(),
      createdAt: DateTime.now(),
    );
    final savedUserMsg = await _messageRepository.create(userMessageEntity);

    final updatedSession = ChatSession(
      id: session.id,
      title: text.length > 40 ? '${text.substring(0, 40)}...' : text,
      messages: [...session.messages, ChatMessage.fromEntity(savedUserMsg)],
      mode: session.mode,
      lastMessageTime: DateTime.now(),
    );

    state = ChatState(
      sessions:
          state.sessions
              .map((s) => s.id == session.id ? updatedSession : s)
              .toList(),
      activeSession: updatedSession,
      isGenerating: true,
    );

    // Generate AI response (placeholder for now, real implementation in Phase 3)
    await _generateResponse(updatedSession, text.trim());
  }

  Future<void> _generateResponse(ChatSession session, String userQuery) async {
    // Show thinking indicator
    final thinkingMsg = ChatMessage(
      id: _nextId++,
      content: '',
      isUser: false,
      timestamp: DateTime.now(),
      isStreaming: true,
    );

    final withThinking = ChatSession(
      id: session.id,
      title: session.title,
      messages: [...session.messages, thinkingMsg],
      mode: session.mode,
      lastMessageTime: DateTime.now(),
    );

    state = ChatState(
      sessions:
          state.sessions
              .map((s) => s.id == session.id ? withThinking : s)
              .toList(),
      activeSession: withThinking,
      isGenerating: true,
    );

    // TODO: Replace with real FFI inference engine call in Phase 3
    await Future.delayed(const Duration(milliseconds: 500));
    final responseText = _generatePlaceholderResponse(userQuery);

    // Save assistant message to database
    final assistantMessageEntity = domain_msg.Message(
      conversationId: session.id,
      role: 'assistant',
      content: responseText,
      createdAt: DateTime.now(),
    );
    final savedAssistantMsg = await _messageRepository.create(
      assistantMessageEntity,
    );

    final finalSession = ChatSession(
      id: session.id,
      title: session.title,
      messages: [
        ...session.messages,
        ChatMessage.fromEntity(savedAssistantMsg),
      ],
      mode: session.mode,
      lastMessageTime: DateTime.now(),
    );

    // Update conversation title and timestamp
    await _conversationRepository.update(
      domain.Conversation(
        id: session.id,
        title: finalSession.title,
        mode: finalSession.mode,
        context: '',
        createdAt: session.messages.first.timestamp,
        updatedAt: DateTime.now(),
      ),
    );

    state = ChatState(
      sessions:
          state.sessions
              .map((s) => s.id == session.id ? finalSession : s)
              .toList(),
      activeSession: finalSession,
      isGenerating: false,
    );
  }

  String _generatePlaceholderResponse(String query) {
    return 'Thank you for your question about "${query.substring(0, query.length.clamp(0, 50))}". '
        'To provide a real AI-powered response, install a local language model through the Model Manager. '
        'Go to Settings > AI Model to download a compatible model for your device. '
        'Once installed, all responses will be generated locally on your device, completely offline.';
  }

  Future<void> stopGeneration() async {
    state = state.copyWith(isGenerating: false);
  }

  Future<void> deleteSession(int sessionId) async {
    await _conversationRepository.delete(sessionId);
    final filtered = state.sessions.where((s) => s.id != sessionId).toList();
    state = ChatState(
      sessions: filtered,
      activeSession:
          state.activeSession?.id == sessionId
              ? (filtered.isEmpty ? null : filtered.first)
              : state.activeSession,
    );
  }

  Future<void> renameSession(int sessionId, String newTitle) async {
    final session = state.sessions.firstWhere((s) => s.id == sessionId);
    await _conversationRepository.update(
      domain.Conversation(
        id: sessionId,
        title: newTitle,
        mode: session.mode,
        context: '',
        createdAt: session.messages.first.timestamp,
        updatedAt: DateTime.now(),
      ),
    );

    final updated =
        state.sessions
            .map(
              (s) =>
                  s.id == sessionId
                      ? ChatSession(
                        id: s.id,
                        title: newTitle,
                        messages: s.messages,
                        mode: s.mode,
                        lastMessageTime: s.lastMessageTime,
                      )
                      : s,
            )
            .toList();

    final active =
        state.activeSession?.id == sessionId
            ? ChatSession(
              id: state.activeSession!.id,
              title: newTitle,
              messages: state.activeSession!.messages,
              mode: state.activeSession!.mode,
              lastMessageTime: state.activeSession!.lastMessageTime,
            )
            : state.activeSession;

    state = ChatState(sessions: updated, activeSession: active);
  }
}
