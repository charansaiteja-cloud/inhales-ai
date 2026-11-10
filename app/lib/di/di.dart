// Dependency injection configuration for InhaleSkill AI.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../domain/repositories/conversation_repository.dart';
import '../domain/repositories/message_repository.dart';
import '../domain/repositories/model_repository.dart';
import '../data/repositories/conversation_repository_impl.dart';
import '../data/repositories/message_repository_impl.dart';
import '../data/repositories/model_repository_impl.dart';

import '../ai/engine/ai_engine.dart' hide ChatMessage;
import '../ai/engine/ffi_ai_engine.dart';
import '../ai/rag/rag_service.dart';
import '../ai/memory/memory_manager.dart';
import '../ai/manager/model_manager.dart';

/// Database provider - creates and manages the AppDatabase instance.
final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});

/// Repository providers - bind interfaces to implementations.
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ConversationRepositoryImpl(database);
});

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return MessageRepositoryImpl(database);
});

final modelRepositoryProvider = Provider<ModelRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ModelRepositoryImpl(database);
});

/// Helper to override repositories for testing.
List<Override> getRepositoryOverrides({
  ConversationRepository? conversationRepo,
  MessageRepository? messageRepo,
  ModelRepository? modelRepo,
}) {
  return [
    if (conversationRepo != null)
      conversationRepositoryProvider.overrideWithValue(conversationRepo),
    if (messageRepo != null)
      messageRepositoryProvider.overrideWithValue(messageRepo),
    if (modelRepo != null) modelRepositoryProvider.overrideWithValue(modelRepo),
  ];
}

/// AI Engine provider - manages local LLM inference.
final aiEngineProvider = Provider<AIEngine>((ref) {
  final engine = FfiAIEngine();
  ref.onDispose(() => engine.dispose());
  return engine;
});

/// RAG Service provider - handles document retrieval.
final ragServiceProvider = Provider<RAGService>((ref) {
  final database = ref.watch(databaseProvider);
  final aiEngine = ref.watch(aiEngineProvider);
  return RAGService(database, embeddingEngine: aiEngine);
});

/// Memory Manager provider - manages conversation memory.
final memoryManagerProvider = Provider<MemoryManager>((ref) {
  final database = ref.watch(databaseProvider);
  return MemoryManager(database);
});

/// Model Manager provider - handles model lifecycle.
final modelManagerProvider = Provider<ModelManager>((ref) {
  // ModelManager is created lazily; this provider is overridden in main()
  // when a real ModelManager instance is available.
  throw UnimplementedError(
    'modelManagerProvider must be overridden with a real ModelManager instance',
  );
});
