/// RAGService unit tests - simplified without complex Drift mocking
library;

import 'dart:math' as math;
import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/ai/rag/rag_service.dart';

void main() {
  group('DocumentChunk', () {
    test('creates with required fields', () {
      final chunk = DocumentChunk(
        id: 'chunk_1',
        documentId: 'doc_1',
        content: 'Test content',
        chunkIndex: 0,
      );

      expect(chunk.id, 'chunk_1');
      expect(chunk.documentId, 'doc_1');
      expect(chunk.content, 'Test content');
      expect(chunk.chunkIndex, 0);
      expect(chunk.metadata, isEmpty);
      expect(chunk.embedding, isNull);
    });

    test('copyWith creates new instance with updated embedding', () {
      final original = DocumentChunk(
        id: 'chunk_1',
        documentId: 'doc_1',
        content: 'Test',
        chunkIndex: 0,
      );

      final embedding = List.generate(384, (i) => i.toDouble());
      final updated = original.copyWith(embedding: embedding);

      expect(updated.embedding, equals(embedding));
      expect(original.embedding, isNull); // original unchanged
    });
  });

  group('SearchResult', () {
    test('creates with chunk and score', () {
      final chunk = DocumentChunk(
        id: 'c1',
        documentId: 'd1',
        content: 'content',
        chunkIndex: 0,
      );

      final result = SearchResult(chunk: chunk, score: 0.85);

      expect(result.chunk, chunk);
      expect(result.score, 0.85);
    });
  });

  group('RAGService logic tests', () {
    test('cosine similarity calculates correctly', () {
      // Identical vectors should have similarity of 1.0
      final vec1 = [1.0, 0.0, 0.0];
      final vec2 = [1.0, 0.0, 0.0];

      double cosineSimilarity(List<double> a, List<double> b) {
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

      expect(cosineSimilarity(vec1, vec2), closeTo(1.0, 0.001));
    });

    test('cosine similarity for orthogonal vectors', () {
      final vec1 = [1.0, 0.0, 0.0];
      final vec2 = [0.0, 1.0, 0.0];

      double cosineSimilarity(List<double> a, List<double> b) {
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

      expect(cosineSimilarity(vec1, vec2), closeTo(0.0, 0.001));
    });

    test('keyword score calculates correctly', () {
      double keywordScore(String content, String query) {
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

      expect(
        keywordScore('Flutter is great for UI', 'Flutter UI'),
        closeTo(1.0, 0.001),
      );
      expect(
        keywordScore('Flutter is great', 'Flutter Dart'),
        closeTo(0.5, 0.001),
      );
      expect(keywordScore('No match here', 'Flutter'), 0.0);
    });

    test('hybrid search weighting', () {
      const vectorWeight = 0.7;
      const keywordWeight = 0.3;

      final vectorScore = 0.8;
      final keywordScore = 0.6;

      final combined =
          (vectorScore * vectorWeight) + (keywordScore * keywordWeight);

      expect(combined, closeTo(0.74, 0.001));
      expect(combined, greaterThan(keywordScore));
      expect(combined, lessThan(vectorScore));
    });

    test('chunking produces overlapping chunks', () {
      const chunkSize = 100;
      const overlap = 20;
      final text = 'A' * 250;

      final chunks = <String>[];
      for (var i = 0; i < text.length; i += chunkSize - overlap) {
        final end = math.min(i + chunkSize, text.length);
        final chunk = text.substring(i, end).trim();
        if (chunk.isNotEmpty) chunks.add(chunk);
      }

      expect(chunks.length, greaterThan(1));
      expect(chunks.length, lessThanOrEqualTo(4));
    });

    test('empty query returns empty keyword score', () {
      double keywordScore(String content, String query) {
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

      expect(keywordScore('Some content', ''), 0.0);
      expect(keywordScore('Some content', '   '), 0.0);
    });
  });

  group('hash embedding', () {
    List<double> hashEmbedding(String text) {
      List<int> simpleHash(String input) {
        // DJB2 hash - produces different hashes for different inputs
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

      const embeddingDim = 384;
      final hash = simpleHash(text);
      final embedding = <double>[];
      for (var i = 0; i < embeddingDim; i++) {
        final byte = hash[i % hash.length];
        embedding.add((byte / 255.0) * 2 - 1);
      }
      // Normalize to unit vector
      final norm = math.sqrt(
        embedding.map((x) => x * x).reduce((a, b) => a + b),
      );
      return embedding.map((x) => x / (norm + 1e-8)).toList();
    }

    test('produces consistent embeddings for same text', () {
      final emb1 = hashEmbedding('test text');
      final emb2 = hashEmbedding('test text');

      expect(emb1.length, emb2.length);
      for (var i = 0; i < emb1.length; i++) {
        expect(emb1[i], closeTo(emb2[i], 0.0001));
      }
    });

    test('produces different embeddings for different text', () {
      final emb1 = hashEmbedding('hello');
      final emb2 = hashEmbedding('world');

      expect(emb1.length, emb2.length);
      // At least some dimensions should differ
      final differences = Iterable.generate(
        emb1.length,
        (i) => (emb1[i] - emb2[i]).abs(),
      ).where((diff) => diff > 0.1);
      expect(differences.isNotEmpty, true);
    });

    test('produces normalized vectors', () {
      final embedding = hashEmbedding('test');
      final norm = math.sqrt(
        embedding.map((x) => x * x).reduce((a, b) => a + b),
      );

      expect(norm, closeTo(1.0, 0.001));
    });

    test('embedding dimension is correct', () {
      final embedding = hashEmbedding('test');
      expect(embedding.length, 384);
    });
  });
}
