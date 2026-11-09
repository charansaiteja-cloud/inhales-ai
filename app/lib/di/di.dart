// Dependency injection configuration for InhaleSkill AI.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../domain/repositories/conversation_repository.dart';
import '../domain/repositories/message_repository.dart';
import '../domain/repositories/model_repository.dart';
import '../data/repositories/conversation_repository_impl.dart';
import '../data/repositories/message_repository_impl.dart';
import '../data/repositories/model_repository_impl.dart';

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
