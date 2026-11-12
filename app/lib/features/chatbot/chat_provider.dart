import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../../../domain/entities/conversation.dart' as domain;
import '../../../domain/entities/message.dart' as domain_msg;
import '../../../domain/repositories/conversation_repository.dart';
import '../../../domain/repositories/message_repository.dart';
import '../../../di/di.dart';
import '../../ai/engine/ai_engine.dart' as ai_engine;
import '../../ai/engine/ai_engine.dart' show AIEngine;
import '../../ai/memory/memory_manager.dart';
import '../../ai/tutor/tutor_personalities.dart';

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
  final bool isPinned;
  final DateTime lastMessageTime;

  const ChatSession({
    required this.id,
    required this.title,
    this.messages = const [],
    this.mode = 'chat',
    this.isPinned = false,
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
      isPinned: conversation.isPinned,
      lastMessageTime: conversation.updatedAt,
    );
  }
}

class ChatState {
  final List<ChatSession> sessions;
  final ChatSession? activeSession;
  final bool isGenerating;
  final String generationError;
  final TutorPersonality? activeTutor;
  final ResponseMode activeResponseMode;
  final List<FollowUpSuggestion> followUpSuggestions;

  const ChatState({
    this.sessions = const [],
    this.activeSession,
    this.isGenerating = false,
    this.generationError = '',
    this.activeTutor,
    this.activeResponseMode = ResponseMode.balanced,
    this.followUpSuggestions = const [],
  });

  ChatState copyWith({
    List<ChatSession>? sessions,
    ChatSession? activeSession,
    bool? isGenerating,
    String? generationError,
    TutorPersonality? activeTutor,
    ResponseMode? activeResponseMode,
    List<FollowUpSuggestion>? followUpSuggestions,
  }) =>
      ChatState(
        sessions: sessions ?? this.sessions,
        activeSession: activeSession ?? this.activeSession,
        isGenerating: isGenerating ?? this.isGenerating,
        generationError: generationError ?? this.generationError,
        activeTutor: activeTutor ?? this.activeTutor,
        activeResponseMode: activeResponseMode ?? this.activeResponseMode,
        followUpSuggestions: followUpSuggestions ?? this.followUpSuggestions,
      );
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final conversationRepo = ref.watch(conversationRepositoryProvider);
  final messageRepo = ref.watch(messageRepositoryProvider);
  final aiEngine = ref.watch(aiEngineProvider);
  final memoryManager = ref.watch(memoryManagerProvider);
  return ChatNotifier(
    conversationRepository: conversationRepo,
    messageRepository: messageRepo,
    aiEngine: aiEngine,
    memoryManager: memoryManager,
  );
});

class ChatNotifier extends StateNotifier<ChatState> {
  final ConversationRepository _conversationRepository;
  final MessageRepository _messageRepository;
  final AIEngine _aiEngine;
  final MemoryManager _memoryManager;
  int _nextId = 1;
  static const int _pageSize = 20;
  int _currentPage = 0;
  bool _hasMore = true;
  bool _isLoading = false;

  ChatNotifier({
    required ConversationRepository conversationRepository,
    required MessageRepository messageRepository,
    required AIEngine aiEngine,
    required MemoryManager memoryManager,
  })  : _conversationRepository = conversationRepository,
        _messageRepository = messageRepository,
        _aiEngine = aiEngine,
        _memoryManager = memoryManager,
        super(const ChatState()) {
    _loadSessions();
  }

  /// Initialize tutor personality for a mode.
  void setTutorForMode(String mode) {
    final tutor = getTutorPersonality(mode);
    final responseMode = ResponseMode.balanced;
    state = state.copyWith(
      activeTutor: tutor,
      activeResponseMode: responseMode,
    );
  }

  /// Change response mode for current session.
  void setResponseMode(ResponseMode mode) {
    state = state.copyWith(activeResponseMode: mode);
  }

  Future<void> _loadSessions({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      state = state.copyWith(sessions: []);
    }

    _isLoading = true;
    try {
      final offset = _currentPage * _pageSize;
      final conversations = await _conversationRepository.getAll(
        limit: _pageSize,
        offset: offset,
      );

      if (conversations.length < _pageSize) {
        _hasMore = false;
      } else {
        _currentPage++;
      }

      final sessions = <ChatSession>[];
      for (final conv in conversations) {
        final messages = await _messageRepository.getByConversation(conv.id!);
        sessions.add(ChatSession.fromEntities(conv, messages));
      }

      state = state.copyWith(
        sessions: refresh ? sessions : [...state.sessions, ...sessions],
        activeSession: state.activeSession ??
            (sessions.isNotEmpty ? sessions.first : null),
      );
    } catch (e) {
      state = state.copyWith(generationError: 'Failed to load sessions: $e');
    } finally {
      _isLoading = false;
    }
  }

  /// Load more conversations for infinite scroll.
  Future<void> loadMoreSessions() async {
    if (!_hasMore) return;
    await _loadSessions();
  }

  /// Refresh all sessions.
  Future<void> refreshSessions() async {
    await _loadSessions(refresh: true);
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

    // Set tutor personality for this mode
    final tutor = getTutorPersonality(session.mode);

    state = ChatState(
      sessions: [session, ...state.sessions],
      activeSession: session,
      activeTutor: tutor,
      activeResponseMode: ResponseMode.balanced,
    );
    return session;
  }

  Future<void> switchSession(ChatSession session) async {
    state = state.copyWith(activeSession: session);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || state.activeSession == null) return;

    final session = state.activeSession!;
    final tutor = state.activeTutor ?? getTutorPersonality(session.mode);
    final responseMode = state.activeResponseMode;

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
      sessions: state.sessions
          .map((s) => s.id == session.id ? updatedSession : s)
          .toList(),
      activeSession: updatedSession,
      isGenerating: true,
      activeTutor: tutor,
      activeResponseMode: responseMode,
    );

    // Generate AI response with tutor personality
    await _generateResponse(updatedSession, text.trim(), tutor, responseMode);
  }

  Future<void> _generateResponse(
    ChatSession session,
    String userQuery,
    TutorPersonality tutor,
    ResponseMode responseMode,
  ) async {
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
      sessions: state.sessions
          .map((s) => s.id == session.id ? withThinking : s)
          .toList(),
      activeSession: withThinking,
      isGenerating: true,
      activeTutor: tutor,
      activeResponseMode: responseMode,
    );

    try {
      // Build chat history from previous messages
      final history = session.messages
          .map(
            (m) => ai_engine.ChatMessage(
              role: m.isUser ? 'user' : 'assistant',
              content: m.content,
              timestamp: m.timestamp,
            ),
          )
          .toList();

      // Build system prompt with tutor personality and response mode
      final systemPrompt = tutor.systemPrompt + responseMode.promptModifier;

      // Get effective generation parameters
      final params = tutor.getEffectiveParams({
        'temperature': 0.7,
        'topP': 0.9,
      });

      // Stream inference from the AI engine with system prompt
      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: userQuery,
        history: history,
        systemPrompt: systemPrompt,
        maxTokens: 1024,
        temperature: params['temperature'] ?? 0.7,
        topP: params['topP'] ?? 0.9,
      )) {
        buffer.write(chunk);
      }

      final responseText = buffer.toString().trim();
      if (responseText.isEmpty) {
        throw StateError('Engine returned empty response');
      }

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

      // Generate follow-up suggestions based on tutor and response mode
      final followUps = _generateFollowUpSuggestions(
        tutor,
        responseMode,
        userQuery,
        responseText,
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

      // Extract facts for long-term memory (fire-and-forget)
      _memoryManager.extractFacts(
          session.id, [userQuery, responseText]).catchError((_) {});

      state = ChatState(
        sessions: state.sessions
            .map((s) => s.id == session.id ? finalSession : s)
            .toList(),
        activeSession: finalSession,
        isGenerating: false,
        activeTutor: tutor,
        activeResponseMode: responseMode,
        followUpSuggestions: followUps,
      );
    } catch (e) {
      state = ChatState(
        sessions: state.sessions
            .map((s) => s.id == session.id ? withThinking : s)
            .toList(),
        activeSession: withThinking,
        isGenerating: false,
        generationError: 'Generation failed: $e',
        activeTutor: tutor,
        activeResponseMode: responseMode,
      );
    }
  }

  /// Generate contextual follow-up suggestions.
  List<FollowUpSuggestion> _generateFollowUpSuggestions(
    TutorPersonality tutor,
    ResponseMode responseMode,
    String userQuery,
    String responseText,
  ) {
    final suggestions = <FollowUpSuggestion>[];

    // Add tutor-specific follow-ups
    for (final template in tutor.suggestedFollowUps) {
      suggestions.add(FollowUpSuggestion(text: template));
    }

    // Add response-mode specific follow-ups
    switch (responseMode) {
      case ResponseMode.explainSimply:
        suggestions.addAll([
          FollowUpSuggestion(text: 'Can you use a different analogy?'),
          FollowUpSuggestion(text: 'What are the key terms I should know?'),
        ]);
        break;
      case ResponseMode.stepByStep:
        suggestions.addAll([
          FollowUpSuggestion(text: 'Can you explain step [N] in more detail?'),
          FollowUpSuggestion(text: 'What if I get stuck on a step?'),
        ]);
        break;
      case ResponseMode.socratic:
        suggestions.addAll([
          FollowUpSuggestion(text: 'I think the answer is...'),
          FollowUpSuggestion(text: 'Can you give me a hint?'),
        ]);
        break;
      case ResponseMode.practiceProblems:
        suggestions.addAll([
          FollowUpSuggestion(text: 'Show me the solution to problem 1'),
          FollowUpSuggestion(text: 'Generate more practice problems'),
        ]);
        break;
      case ResponseMode.examPrep:
        suggestions.addAll([
          FollowUpSuggestion(text: 'What are the most likely exam questions?'),
          FollowUpSuggestion(text: 'Create a summary sheet for this topic'),
        ]);
        break;
      case ResponseMode.codeTutor:
        suggestions.addAll([
          FollowUpSuggestion(text: 'How would you optimize this code?'),
          FollowUpSuggestion(text: 'Write a test case for this function'),
        ]);
        break;
      default:
        break;
    }

    // Limit to 5 suggestions
    return suggestions.take(5).toList();
  }

  Future<void> stopGeneration() async {
    _aiEngine.cancel();
    state = state.copyWith(isGenerating: false);
  }

  Future<void> togglePin(int sessionId) async {
    final session = state.sessions.firstWhere((s) => s.id == sessionId);
    final newPinned = !session.isPinned;
    await _conversationRepository.setPinned(sessionId, newPinned);

    final updated = state.sessions
        .map(
          (s) => s.id == sessionId
              ? ChatSession(
                  id: s.id,
                  title: s.title,
                  messages: s.messages,
                  mode: s.mode,
                  isPinned: newPinned,
                  lastMessageTime: s.lastMessageTime,
                )
              : s,
        )
        .toList();

    final active = state.activeSession?.id == sessionId
        ? ChatSession(
            id: state.activeSession!.id,
            title: state.activeSession!.title,
            messages: state.activeSession!.messages,
            mode: state.activeSession!.mode,
            isPinned: newPinned,
            lastMessageTime: state.activeSession!.lastMessageTime,
          )
        : state.activeSession;

    state = ChatState(sessions: updated, activeSession: active);
  }

  Future<void> deleteSession(int sessionId) async {
    await _conversationRepository.delete(sessionId);
    final filtered = state.sessions.where((s) => s.id != sessionId).toList();
    state = ChatState(
      sessions: filtered,
      activeSession: state.activeSession?.id == sessionId
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
        createdAt: session.messages.isNotEmpty
            ? session.messages.first.timestamp
            : session.lastMessageTime,
        updatedAt: DateTime.now(),
      ),
    );

    final updated = state.sessions
        .map(
          (s) => s.id == sessionId
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

    final active = state.activeSession?.id == sessionId
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

  /// Search messages across all sessions.
  List<ChatMessage> searchMessages(String query) {
    if (query.trim().isEmpty) return [];
    final lowerQuery = query.toLowerCase();
    final results = <ChatMessage>[];
    for (final session in state.sessions) {
      for (final msg in session.messages) {
        if (msg.content.toLowerCase().contains(lowerQuery)) {
          results.add(msg);
        }
      }
    }
    return results;
  }

  /// Export a conversation as markdown.
  Future<String> exportAsMarkdown(int sessionId) async {
    final session = state.sessions.firstWhere((s) => s.id == sessionId);
    final buffer = StringBuffer();
    buffer.writeln('# ${session.title}');
    buffer.writeln();
    buffer.writeln('_Exported on ${DateTime.now().toString()}_');
    buffer.writeln();
    for (final msg in session.messages) {
      buffer.writeln('## ${msg.isUser ? 'You' : 'InhaleSkill AI'}');
      buffer.writeln();
      buffer.writeln(msg.content);
      buffer.writeln();
      buffer.writeln('---');
      buffer.writeln();
    }
    return buffer.toString();
  }

  /// Export a conversation as JSON.
  Future<String> exportAsJson(int sessionId) async {
    final session = state.sessions.firstWhere((s) => s.id == sessionId);
    final buffer = StringBuffer('{');
    buffer.writeln('  "id": ${session.id},');
    buffer.writeln('  "title": "${session.title}",');
    buffer.writeln('  "mode": "${session.mode}",');
    buffer.writeln('  "messages": [');
    for (var i = 0; i < session.messages.length; i++) {
      final msg = session.messages[i];
      final comma = i < session.messages.length - 1 ? ',' : '';
      buffer.writeln('    {');
      buffer.writeln('      "role": "${msg.isUser ? "user" : "assistant"}",');
      buffer.writeln(
        '      "content": "${msg.content.replaceAll('"', '\\"')}"',
      );
      buffer.writeln('    }$comma');
    }
    buffer.writeln('  ]');
    buffer.write('}');
    return buffer.toString();
  }

  /// Share a conversation via the system share sheet.
  Future<void> shareConversation(
    int sessionId, {
    String format = 'markdown',
  }) async {
    final content = format == 'json'
        ? await exportAsJson(sessionId)
        : await exportAsMarkdown(sessionId);
    final tempDir = await getTemporaryDirectory();
    final ext = format == 'json' ? 'json' : 'md';
    final file = File('${tempDir.path}/conversation_$sessionId.$ext');
    await file.writeAsString(content);
    await Share.shareXFiles([XFile(file.path)]);
  }
}
