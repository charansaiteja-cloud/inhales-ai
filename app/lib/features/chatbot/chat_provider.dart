import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Chat state model.
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
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>(
  (ref) => ChatNotifier(),
);

class ChatNotifier extends StateNotifier<ChatState> {
  int _nextId = 1;

  ChatNotifier() : super(const ChatState());

  Future<ChatSession> newSession({String? mode}) async {
    final session = ChatSession(
      id: _nextId++,
      title: 'New Conversation',
      mode: mode ?? 'chat',
      lastMessageTime: DateTime.now(),
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
    if (text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: _nextId++,
      content: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    final session = state.activeSession!;
    final updatedSession = ChatSession(
      id: session.id,
      title: text.length > 40 ? '${text.substring(0, 40)}...' : text,
      messages: [...session.messages, userMsg],
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

    // Simulate AI response (real implementation calls local inference engine)
    await _simulateResponse(updatedSession);
  }

  Future<void> _simulateResponse(ChatSession session) async {
    // In production this calls the local inference engine via FFI.
    // The streaming implementation connects to FfiInferenceEngine.
    final thinking = ChatMessage(
      id: _nextId++,
      content: '',
      isUser: false,
      timestamp: DateTime.now(),
      isStreaming: true,
    );

    final updated = ChatSession(
      id: session.id,
      title: session.title,
      messages: [...session.messages, thinking],
      mode: session.mode,
      lastMessageTime: DateTime.now(),
    );

    state = ChatState(
      sessions:
          state.sessions.map((s) => s.id == session.id ? updated : s).toList(),
      activeSession: updated,
      isGenerating: true,
    );

    // Simulated streaming response
    await Future.delayed(const Duration(milliseconds: 500));
    final response = ChatMessage(
      id: _nextId++,
      content: _generatePlaceholderResponse(
        session.messages.lastWhere((m) => m.isUser).content,
      ),
      isUser: false,
      timestamp: DateTime.now(),
    );

    final finalSession = ChatSession(
      id: session.id,
      title: session.title,
      messages: [
        ...session.messages.sublist(0, session.messages.length - 1),
        response,
      ],
      mode: session.mode,
      lastMessageTime: DateTime.now(),
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

extension on ChatState {
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
