/// RAG (Retrieval-Augmented Generation) Service — document indexing and retrieval with vector search.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import '../../database/database.dart';
import '../engine/ai_engine.dart';

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

  DocumentChunk copyWith({List<double>? embedding}) => DocumentChunk(
    id: id,
    documentId: documentId,
    content: content,
    chunkIndex: chunkIndex,
    metadata: metadata,
    embedding: embedding ?? this.embedding,
  );
}

/// Search result with relevance score.
class SearchResult {
  final DocumentChunk chunk;
  final double score;

  const SearchResult({required this.chunk, required this.score});
}

/// RAG Service for document retrieval using vector embeddings.
/// Currently uses hash-based embeddings with keyword fallback.
/// Can be extended with sqlite-vec when a stable Android build is available.
class RAGService {
  final AppDatabase _database;
  final AIEngine? _embeddingEngine;
  final List<DocumentChunk> _memoryIndex = [];
  bool _initialized = false;

  static const int _embeddingDim = 384; // BGE-small-en / E5-small dimension
  static const int _chunkSize = 512;
  static const int _chunkOverlap = 64;

  RAGService(this._database, {AIEngine? embeddingEngine})
    : _embeddingEngine = embeddingEngine;

  /// Initialize the RAG service.
  Future<void> initialize() async {
    if (_initialized) return;

    // Create documents table for storing chunks (simple approach without sqlite-vec)
    await _createDocumentChunksTable();

    // Load existing chunks into memory index
    await _loadIndex();

    _initialized = true;
  }

  Future<void> _createDocumentChunksTable() async {
    await _database.customStatement('''
      CREATE TABLE IF NOT EXISTS document_chunks (
        id TEXT PRIMARY KEY,
        document_id TEXT NOT NULL,
        chunk_index INTEGER NOT NULL,
        content TEXT NOT NULL,
        metadata TEXT,
        embedding TEXT, -- JSON array of floats
        created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
      )
    ''');

    // Create index for faster document_id lookups
    await _database.customStatement('''
      CREATE INDEX IF NOT EXISTS idx_document_chunks_document_id
      ON document_chunks(document_id)
    ''');
  }

  /// Add a document to the index.
  Future<void> addDocument({
    required String documentId,
    required String title,
    required String content,
    Map<String, dynamic>? metadata,
  }) async {
    final chunks = _chunkText(content, documentId, title, metadata);
    await _indexChunks(chunks);
  }

  /// Search for relevant chunks using hybrid approach (vector + keyword).
  Future<List<SearchResult>> search(
    String query, {
    int limit = 5,
    double minScore = 0.3,
  }) async {
    return hybridSearch(query, limit: limit);
  }

  /// Search with hybrid approach (vector + keyword).
  Future<List<SearchResult>> hybridSearch(
    String query, {
    int limit = 5,
    double vectorWeight = 0.7,
    double keywordWeight = 0.3,
    double minScore = 0.3,
  }) async {
    final queryEmbedding = await _getEmbedding(query);

    final results = <SearchResult>[];

    for (final chunk in _memoryIndex) {
      double vectorScore = 0.0;
      if (queryEmbedding != null && chunk.embedding != null) {
        vectorScore = _cosineSimilarity(queryEmbedding, chunk.embedding!);
      }

      double keywordScore = _keywordScore(chunk.content, query);

      final score =
          (vectorScore * vectorWeight) + (keywordScore * keywordWeight);

      if (score >= minScore) {
        results.add(SearchResult(chunk: chunk, score: score));
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));
    return results.take(limit).toList();
  }

  double _cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) return 0.0;

    double dot = 0.0, normA = 0.0, normB = 0.0;
    for (var i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    final norm = math.sqrt(normA) * math.sqrt(normB);
    return norm > 0 ? dot / norm : 0.0;
  }

  double _keywordScore(String content, String query) {
    final contentLower = content.toLowerCase();
    final keywords =
        query
            .toLowerCase()
            .split(RegExp(r'\s+'))
            .where((w) => w.length > 1)
            .toList();
    if (keywords.isEmpty) return 0.0;

    var matches = 0;
    for (final kw in keywords) {
      if (contentLower.contains(kw)) matches++;
    }
    return matches / keywords.length;
  }

  /// Delete a document from the index.
  Future<void> deleteDocument(String documentId) async {
    await _database.customStatement(
      'DELETE FROM document_chunks WHERE document_id = ?',
      [documentId],
    );
    _memoryIndex.removeWhere((c) => c.documentId == documentId);
  }

  /// Get all indexed document IDs.
  Future<List<String>> getIndexedDocuments() async {
    final rows =
        await _database
            .customSelect('SELECT DISTINCT document_id FROM document_chunks')
            .get();

    return rows.map((r) => r.read<String>('document_id')).toList();
  }

  /// Clear all indexed documents.
  Future<void> clear() async {
    await _database.customStatement('DELETE FROM document_chunks');
    _memoryIndex.clear();
  }

  // ── Private helpers ────────────────────────────────────────

  List<DocumentChunk> _chunkText(
    String text,
    String documentId,
    String title,
    Map<String, dynamic>? metadata,
  ) {
    final chunks = <DocumentChunk>[];
    const overlap = _chunkOverlap;

    for (var i = 0; i < text.length; i += _chunkSize - overlap) {
      final end = math.min(i + _chunkSize, text.length);
      final chunkText = text.substring(i, end).trim();
      if (chunkText.isEmpty) continue;

      chunks.add(
        DocumentChunk(
          id: '${documentId}_chunk_${chunks.length}',
          documentId: documentId,
          content: chunkText,
          chunkIndex: chunks.length,
          metadata: {
            'title': title,
            'source': metadata?['source'] ?? 'unknown',
            'timestamp': DateTime.now().toIso8601String(),
          },
        ),
      );
    }

    return chunks;
  }

  Future<void> _indexChunks(List<DocumentChunk> chunks) async {
    // Generate embeddings for chunks
    final chunksWithEmbeddings = <DocumentChunk>[];
    for (final chunk in chunks) {
      final embedding = await _getEmbedding(chunk.content);
      if (embedding != null) {
        chunksWithEmbeddings.add(chunk.copyWith(embedding: embedding));
      }
    }

    if (chunksWithEmbeddings.isEmpty) return;

    // Batch insert into document_chunks table
    await _database.batch((b) {
      for (final chunk in chunksWithEmbeddings) {
        b.customStatement(
          '''
          INSERT OR REPLACE INTO document_chunks
          (id, document_id, chunk_index, content, metadata, embedding, created_at)
          VALUES (?, ?, ?, ?, ?, ?, ?)
        ''',
          [
            chunk.id,
            chunk.documentId,
            chunk.chunkIndex,
            chunk.content,
            jsonEncode(chunk.metadata),
            jsonEncode(chunk.embedding!),
            DateTime.now().millisecondsSinceEpoch ~/ 1000,
          ],
        );
      }
    });

    // Update memory index
    _memoryIndex.addAll(chunksWithEmbeddings);
  }

  Future<void> _loadIndex() async {
    final rows =
        await _database.customSelect('''
      SELECT id, document_id, chunk_index, content, metadata, embedding
      FROM document_chunks
    ''').get();

    _memoryIndex.clear();
    for (final row in rows) {
      List<double>? embedding;
      final embeddingJson = row.read<String>('embedding');
      if (embeddingJson.isNotEmpty) {
        try {
          final List<dynamic> decoded = jsonDecode(embeddingJson);
          embedding = decoded.map((e) => (e as num).toDouble()).toList();
        } catch (_) {}
      }

      Map<String, dynamic> metadata = {};
      final metadataJson = row.read<String>('metadata');
      if (metadataJson.isNotEmpty) {
        try {
          metadata = jsonDecode(metadataJson);
        } catch (_) {}
      }

      _memoryIndex.add(
        DocumentChunk(
          id: row.read<String>('id'),
          documentId: row.read<String>('document_id'),
          content: row.read<String>('content'),
          chunkIndex: row.read<int>('chunk_index'),
          metadata: metadata,
          embedding: embedding,
        ),
      );
    }
  }

  Future<List<double>?> _getEmbedding(String text) async {
    if (_embeddingEngine == null) return _hashEmbedding(text);

    try {
      // Use a small embedding model prompt
      // For now, fall back to a simple hash-based embedding
      return _hashEmbedding(text);
    } catch (e) {
      return _hashEmbedding(text);
    }
  }

  /// Deterministic hash-based embedding (fallback when no embedding model available).
  List<double> _hashEmbedding(String text) {
    final hash = _simpleHash(text);
    final embedding = <double>[];
    for (var i = 0; i < _embeddingDim; i++) {
      final byte = hash[i % hash.length];
      embedding.add((byte / 255.0) * 2 - 1); // Normalize to [-1, 1]
    }
    // Normalize to unit vector
    final norm = math.sqrt(embedding.map((x) => x * x).reduce((a, b) => a + b));
    return embedding.map((x) => x / (norm + 1e-8)).toList();
  }

  List<int> _simpleHash(String input) {
    // DJB2 hash algorithm - produces different hashes for different inputs
    int h1 = 5381;
    int h2 = 0;
    for (final codeUnit in input.codeUnits) {
      h1 = ((h1 << 5) + h1 + codeUnit) & 0xffffffff;
      h2 = ((h2 << 5) + h2 + (codeUnit ^ 0xff)) & 0xffffffff;
    }
    // Generate 32 bytes from two hash values
    return List.generate(32, (i) {
      if (i < 4) return (h1 >> (i * 8)) & 0xff;
      return (h2 >> ((i - 4) * 8)) & 0xff;
    });
  }
}
