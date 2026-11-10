/// RAG (Retrieval-Augmented Generation) Service — document indexing and retrieval.
library;

import 'dart:async';
import 'dart:math';
import 'package:drift/drift.dart';

import '../../../database/database.dart';

/// Document chunk for RAG.
class DocumentChunk {
  final String id;
  final String documentId;
  final String content;
  final int chunkIndex;
  final Map<String, dynamic> metadata;
  final List<double>? embedding;

  const DocumentChunk({
    required this.id,
    required this.documentId,
    required this.content,
    required this.chunkIndex,
    this.metadata = const {},
    this.embedding,
  });
}

/// RAG Service for document retrieval.
class RAGService {
  final AppDatabase _database;
  final List<DocumentChunk> _index = [];
  bool _initialized = false;

  RAGService(this._database);

  /// Initialize the RAG service.
  Future<void> initialize() async {
    if (_initialized) return;
    await _loadIndex();
    _initialized = true;
  }

  /// Add a document to the index.
  Future<void> addDocument({
    required String documentId,
    required String title,
    required String content,
    Map<String, dynamic> metadata = const {},
  }) async {
    final chunks = _chunkText(
      content,
      documentId,
      metadata: {'title': title, ...metadata},
    );

    for (final chunk in chunks) {
      _index.add(chunk);
      // Persist to database
      await _database
          .into(_database.documents)
          .insert(
            DocumentsCompanion.insert(
              title: title,
              filePath: documentId,
              fileType: 'text',
              sizeBytes: content.length,
              extractedText: Value(content),
              summary: Value(metadata['summary'] as String?),
              importedAt: DateTime.now(),
            ),
          );
    }
  }

  /// Remove a document from the index.
  Future<void> removeDocument(String documentId) async {
    _index.removeWhere((c) => c.documentId == documentId);
    // Also remove from database
    await (_database.delete(_database.documents)
      ..where((d) => d.filePath.equals(documentId))).go();
  }

  /// Search for relevant chunks.
  Future<List<DocumentChunk>> search({
    required String query,
    int topK = 5,
    double minSimilarity = 0.3,
  }) async {
    if (!_initialized) await initialize();

    // Simple keyword-based search (in production, use embeddings)
    final queryTerms = _tokenize(query.toLowerCase());
    if (queryTerms.isEmpty) return [];

    final scored = <MapEntry<DocumentChunk, double>>[];

    for (final chunk in _index) {
      final score = _computeSimilarity(queryTerms, chunk);
      if (score >= minSimilarity) {
        scored.add(MapEntry(chunk, score));
      }
    }

    scored.sort((a, b) => b.value.compareTo(a.value));
    return scored.take(topK).map((e) => e.key).toList();
  }

  /// Get context string for RAG prompt.
  Future<String> getContext(String query, {int maxTokens = 2000}) async {
    final chunks = await search(query: query, topK: 5);
    if (chunks.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.writeln('<<CONTEXT>>');
    var tokenCount = 0;

    for (final chunk in chunks) {
      final chunkText = chunk.content;
      final estTokens = (chunkText.length / 4).ceil();
      if (tokenCount + estTokens > maxTokens) break;
      tokenCount += estTokens;
      buffer.writeln('[Document: ${chunk.metadata['title'] ?? 'Unknown'}]');
      buffer.writeln(chunkText);
      buffer.writeln();
    }
    buffer.writeln('<</CONTEXT>>');

    return buffer.toString();
  }

  List<DocumentChunk> _chunkText(
    String text,
    String documentId, {
    int chunkSize = 500,
    int overlap = 50,
    Map<String, dynamic> metadata = const {},
  }) {
    final chunks = <DocumentChunk>[];
    final words = text.split(RegExp(r'\s+'));

    for (var i = 0; i < words.length; i += chunkSize - overlap) {
      final end = min(i + chunkSize, words.length);
      final chunkWords = words.sublist(i, end);
      final content = chunkWords.join(' ');

      if (content.trim().isNotEmpty) {
        chunks.add(
          DocumentChunk(
            id: '${documentId}_chunk_${chunks.length}',
            documentId: documentId,
            content: content.trim(),
            chunkIndex: chunks.length,
            metadata: metadata,
          ),
        );
      }

      if (end >= words.length) break;
    }

    return chunks;
  }

  List<String> _tokenize(String text) {
    return text
        .split(RegExp(r'[^\w]+'))
        .where((t) => t.length > 2)
        .toSet()
        .toList();
  }

  double _computeSimilarity(List<String> queryTerms, DocumentChunk chunk) {
    final chunkTerms = _tokenize(chunk.content.toLowerCase()).toSet();
    if (chunkTerms.isEmpty) return 0.0;

    int matches = 0;
    for (final term in queryTerms) {
      if (chunkTerms.contains(term)) matches++;
    }

    return matches / queryTerms.length;
  }

  Future<void> _loadIndex() async {
    final docs = await _database.select(_database.documents).get();
    for (final doc in docs) {
      if (doc.extractedText != null && doc.extractedText!.isNotEmpty) {
        final chunks = _chunkText(
          doc.extractedText!,
          doc.filePath,
          metadata: {'title': doc.title},
        );
        _index.addAll(chunks);
      }
    }
  }
}
