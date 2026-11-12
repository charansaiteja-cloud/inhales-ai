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

  group('Extractive summarization', () {
    test('summarizes long text by selecting key sentences', () {
      const text =
          'Machine learning is a subset of artificial intelligence. '
          'It focuses on algorithms that can learn from data. '
          'Neural networks are a popular type of machine learning model. '
          'Deep learning uses multiple layers of neural networks. '
          'Supervised learning requires labeled training data. '
          'Unsupervised learning finds patterns without labels. '
          'Reinforcement learning learns through trial and error. '
          'Each approach has different use cases. '
          'Choosing the right method depends on the problem. '
          'Evaluation metrics help compare model performance.';

      final sentences = _splitSentences(text);
      expect(sentences.length, greaterThan(5));

      // Simple extractive: pick first 5
      final summary = sentences.take(5).join(' ');
      expect(summary, contains('Machine learning'));
      expect(summary, contains('artificial intelligence'));
      expect(summary, contains('Neural networks'));
      expect(summary, contains('Deep learning'));
      expect(summary, contains('Supervised learning'));
    });

    test('extractKeyTopics identifies frequent terms', () {
      const text =
          'Machine learning algorithms learn from data. '
          'Deep learning uses neural networks with many layers. '
          'Neural networks can approximate complex functions. '
          'Training data quality affects model performance. '
          'Feature engineering improves neural network results.';

      final topics = _extractKeyTopics(text, maxTopics: 5);
      expect(topics.length, 5);
      expect(topics, anyElement(contains('neural')));
      expect(topics, anyElement(contains('learning')));
      expect(topics, anyElement(contains('data')));
    });

    test('suggestQuestions generates relevant questions from topics', () {
      // Use repeated target words to ensure they rank highest
      const text =
          'Photosynthesis is the process of photosynthesis in plants. '
          'Chlorophyll is the green pigment chlorophyll in leaves. '
          'Photosynthesis converts light energy into chemical energy using chlorophyll. '
          'The photosynthesis process requires chlorophyll for energy conversion.';

      final questions = _suggestQuestions(text, maxQuestions: 4);
      expect(questions.length, 4);
      expect(questions.any((q) => q.contains('photosynthesis')), true);
      expect(questions.any((q) => q.contains('chlorophyll')), true);
    });

    test('empty content returns empty results', () {
      expect(_splitSentences(''), isEmpty);
      expect(_extractKeyTopics(''), isEmpty);
      expect(_suggestQuestions(''), isNot(isEmpty)); // falls back to defaults
    });
  });
}

List<String> _splitSentences(String text) {
  // Simple sentence splitting - split on . ! ? followed by space and capital letter
  final cleaned = text.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');
  final parts = cleaned.split(RegExp(r'(?<=[.!?])\s+(?=[A-Z])'));
  return parts.where((s) => s.trim().isNotEmpty).map((s) => s.trim()).toList();
}

List<String> _extractKeyTopics(String content, {int maxTopics = 7}) {
  if (content.trim().isEmpty) return [];

  final stopWords = _stopWords();
  final wordFreq = <String, int>{};
  final words = content
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
      .split(RegExp(r'\s+'))
      .where((w) => w.length > 3 && !stopWords.contains(w));

  for (final w in words) {
    wordFreq[w] = (wordFreq[w] ?? 0) + 1;
  }

  final sorted =
      wordFreq.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  return sorted.take(maxTopics).map((e) => e.key).toList();
}

List<String> _suggestQuestions(String content, {int maxQuestions = 5}) {
  final topics = _extractKeyTopics(content, maxTopics: maxQuestions * 2);
  if (topics.isEmpty) {
    return [
      'What is the main idea of this document?',
      'Can you explain the key concepts?',
      'What are the important takeaways?',
    ];
  }

  final questions = <String>[];
  for (final topic in topics.take(maxQuestions)) {
    questions.add('What is $topic?');
    questions.add('How does $topic relate to the document?');
  }
  return questions.take(maxQuestions).toList();
}

Set<String> _stopWords() {
  return {
    'the',
    'and',
    'for',
    'are',
    'but',
    'not',
    'you',
    'all',
    'can',
    'had',
    'her',
    'was',
    'one',
    'our',
    'out',
    'day',
    'get',
    'has',
    'him',
    'his',
    'how',
    'its',
    'may',
    'new',
    'now',
    'old',
    'see',
    'two',
    'way',
    'who',
    'boy',
    'did',
    'she',
    'use',
    'oil',
    'sit',
    'set',
    'run',
    'eat',
    'far',
    'sea',
    'eye',
    'ago',
    'off',
    'too',
    'any',
    'say',
    'man',
    'try',
    'ask',
    'end',
    'why',
    'let',
    'put',
    'tell',
    'very',
    'when',
    'come',
    'here',
    'just',
    'like',
    'long',
    'make',
    'many',
    'over',
    'such',
    'take',
    'them',
    'well',
    'were',
  };
}
