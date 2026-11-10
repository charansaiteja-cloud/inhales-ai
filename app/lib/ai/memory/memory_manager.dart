/// Memory Manager — conversation memory and context management.
library;

import 'dart:async';
import 'dart:math' as math;
import 'package:drift/drift.dart';

import '../../../database/database.dart';

/// Memory entry for conversation context.
class MemoryEntry {
  final String id;
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
}

/// Memory Manager for long-term conversation memory.
class MemoryManager {
  final AppDatabase _database;
  final Map<int, List<MemoryEntry>> _cache = {};
  final int _maxMemoriesPerConversation = 50;

  MemoryManager(this._database);

  /// Add a memory entry.
  Future<void> addMemory({
    required int conversationId,
    required String type,
    required String content,
    double importance = 0.5,
  }) async {
    final entry = MemoryEntry(
      id: '${conversationId}_${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      type: type,
      content: content,
      createdAt: DateTime.now(),
      importance: importance,
    );

    _cache.putIfAbsent(conversationId, () => []).add(entry);
    _pruneCache(conversationId);

    // Persist to database (using preferences table for now)
    await _database
        .into(_database.preferences)
        .insert(
          PreferencesCompanion.insert(
            key: 'memory_${entry.id}',
            value: _encodeMemory(entry),
          ),
        );
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
    final prefs =
        await (_database.select(_database.preferences)
          ..where((p) => p.key.like('memory_${conversationId}_%'))).get();

    final memories =
        prefs
            .map((p) => _decodeMemory(p.key, p.value))
            .whereType<MemoryEntry>()
            .toList();
    _cache[conversationId] = memories;
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

  String _encodeMemory(MemoryEntry entry) {
    return '${entry.type}|${entry.content}|${entry.createdAt.toIso8601String()}|${entry.importance}';
  }

  MemoryEntry? _decodeMemory(String key, String value) {
    try {
      final parts = value.split('|');
      if (parts.length != 4) return null;
      final id = key.replaceFirst('memory_', '');
      final conversationIdStr = id.split('_').first;
      final conversationId = int.tryParse(conversationIdStr) ?? 0;
      return MemoryEntry(
        id: id,
        conversationId: conversationId,
        type: parts[0],
        content: parts[1],
        createdAt: DateTime.parse(parts[2]),
        importance: double.parse(parts[3]),
      );
    } catch (_) {
      return null;
    }
  }
}
