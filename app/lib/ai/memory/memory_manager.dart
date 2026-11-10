/// Memory Manager — conversation memory and context management with persistent storage.
library;

import 'dart:async';
import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../../database/database.dart';

/// Memory entry for conversation context.
class MemoryEntry {
  final int id;
  final int conversationId;
  final String type; // 'summary', 'fact', 'preference', 'topic'
  final String content;
  final DateTime createdAt;
  final double importance; // 0.0 - 1.0

  const MemoryEntry({
    required this.id,
    required this.conversationId,
    required this.type,
    required this.content,
    required this.createdAt,
    this.importance = 0.5,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'conversationId': conversationId,
    'type': type,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'importance': importance,
  };

  factory MemoryEntry.fromJson(Map<String, dynamic> json) => MemoryEntry(
    id: json['id'] as int,
    conversationId: json['conversationId'] as int,
    type: json['type'] as String,
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    importance: (json['importance'] as num?)?.toDouble() ?? 0.5,
  );
}

/// Memory Manager for long-term conversation memory.
class MemoryManager {
  final AppDatabase _database;
  final Map<int, List<MemoryEntry>> _cache = {};
  final int _maxMemoriesPerConversation = 50;

  MemoryManager(this._database);

  /// Add a memory entry.
  Future<int> addMemory({
    required int conversationId,
    required String type,
    required String content,
    double importance = 0.5,
  }) async {
    final now = DateTime.now();
    final entry = MemoriesCompanion.insert(
      conversationId: conversationId,
      type: type,
      content: content,
      importance: Value(importance),
      createdAt: now,
    );

    final id = await _database.into(_database.memories).insert(entry);

    final memoryEntry = MemoryEntry(
      id: id,
      conversationId: conversationId,
      type: type,
      content: content,
      createdAt: now,
      importance: importance,
    );

    _cache.putIfAbsent(conversationId, () => []).add(memoryEntry);
    _pruneCache(conversationId);

    return id;
  }

  /// Get memories for a conversation.
  Future<List<MemoryEntry>> getMemories(
    int conversationId, {
    int limit = 20,
    String? type,
  }) async {
    if (!_cache.containsKey(conversationId)) {
      await _loadMemories(conversationId);
    }

    var memories = _cache[conversationId] ?? [];

    if (type != null) {
      memories = memories.where((m) => m.type == type).toList();
    }

    memories.sort((a, b) => b.importance.compareTo(a.importance));
    return memories.take(limit).toList();
  }

  /// Get relevant memories for a query.
  Future<String> getRelevantContext(
    int conversationId,
    String query, {
    int maxTokens = 1000,
  }) async {
    final memories = await getMemories(conversationId, limit: 30);
    final queryTerms = _tokenize(query.toLowerCase());

    if (memories.isEmpty || queryTerms.isEmpty) return '';

    final scored = <MapEntry<MemoryEntry, double>>[];
    for (final mem in memories) {
      final score = _computeSimilarity(queryTerms, mem);
      if (score > 0) {
        scored.add(MapEntry(mem, score));
      }
    }

    scored.sort((a, b) => b.value.compareTo(a.value));

    final buffer = StringBuffer();
    buffer.writeln('<<MEMORY>>');
    var tokenCount = 0;

    for (final entry in scored.map((e) => e.key)) {
      final text = '${entry.type}: ${entry.content}';
      final estTokens = (text.length / 4).ceil();
      if (tokenCount + estTokens > maxTokens) break;
      tokenCount += estTokens;
      buffer.writeln(text);
    }
    buffer.writeln('<</MEMORY>>');

    return buffer.toString();
  }

  /// Extract and store facts from a conversation.
  Future<void> extractFacts(int conversationId, List<String> messages) async {
    // Simple heuristic: look for statements that sound like facts/preferences
    for (final msg in messages) {
      if (_looksLikeFact(msg)) {
        await addMemory(
          conversationId: conversationId,
          type: 'fact',
          content: msg,
          importance: 0.7,
        );
      } else if (_looksLikePreference(msg)) {
        await addMemory(
          conversationId: conversationId,
          type: 'preference',
          content: msg,
          importance: 0.8,
        );
      }
    }
  }

  /// Create a conversation summary.
  Future<void> createSummary(int conversationId, List<String> messages) async {
    if (messages.isEmpty) return;

    // Simple summary: first and last few messages + length
    final summary =
        'Conversation with ${messages.length} messages. '
        'Started: "${messages.first.substring(0, math.min(50, messages.first.length))}..." '
        'Ended: "${messages.last.substring(0, math.min(50, messages.last.length))}..."';

    await addMemory(
      conversationId: conversationId,
      type: 'summary',
      content: summary,
      importance: 0.9,
    );
  }

  /// Delete a specific memory.
  Future<void> deleteMemory(int memoryId) async {
    await (_database.delete(_database.memories)
      ..where((m) => m.id.equals(memoryId))).go();

    // Clear cache to force reload
    for (final convId in _cache.keys) {
      _cache[convId] = _cache[convId]!.where((m) => m.id != memoryId).toList();
    }
  }

  /// Delete all memories for a conversation.
  Future<void> deleteConversationMemories(int conversationId) async {
    await (_database.delete(_database.memories)
      ..where((m) => m.conversationId.equals(conversationId))).go();

    _cache.remove(conversationId);
  }

  void _pruneCache(int conversationId) {
    final list = _cache[conversationId];
    if (list != null && list.length > _maxMemoriesPerConversation) {
      list.sort((a, b) => a.importance.compareTo(b.importance));
      _cache[conversationId] = list.sublist(
        list.length - _maxMemoriesPerConversation,
      );
    }
  }

  Future<void> _loadMemories(int conversationId) async {
    final query =
        _database.select(_database.memories)
          ..where((m) => m.conversationId.equals(conversationId))
          ..orderBy([(m) => OrderingTerm.desc(m.createdAt)])
          ..limit(_maxMemoriesPerConversation);

    final rows = await query.get();

    _cache[conversationId] =
        rows
            .map(
              (row) => MemoryEntry(
                id: row.id,
                conversationId: row.conversationId,
                type: row.type,
                content: row.content,
                createdAt: row.createdAt,
                importance: row.importance,
              ),
            )
            .toList();
  }

  List<String> _tokenize(String text) {
    return text
        .split(RegExp(r'[^\w]+'))
        .where((t) => t.length > 2)
        .toSet()
        .toList();
  }

  double _computeSimilarity(List<String> queryTerms, MemoryEntry memory) {
    final memTerms = _tokenize(memory.content.toLowerCase()).toSet();
    if (memTerms.isEmpty) return 0.0;

    int matches = 0;
    for (final term in queryTerms) {
      if (memTerms.contains(term)) matches++;
    }

    return matches / queryTerms.length * memory.importance;
  }

  bool _looksLikeFact(String text) {
    final lower = text.toLowerCase();
    return lower.contains('i am') ||
        lower.contains('my name is') ||
        lower.contains('i work') ||
        lower.contains('i study') ||
        lower.contains('i live') ||
        lower.contains('i like') ||
        lower.contains('i know') ||
        lower.contains('i have');
  }

  bool _looksLikePreference(String text) {
    final lower = text.toLowerCase();
    return lower.contains('i prefer') ||
        lower.contains('i like') ||
        lower.contains('i hate') ||
        lower.contains('i love') ||
        lower.contains('favorite') ||
        lower.contains('preferred');
  }
}
