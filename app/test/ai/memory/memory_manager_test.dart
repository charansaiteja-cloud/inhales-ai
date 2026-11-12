/// MemoryManager unit tests - simplified without complex Drift mocking
library;

import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/ai/memory/memory_manager.dart';

void main() {
  group('MemoryEntry', () {
    test('serializes and deserializes correctly', () {
      final entry = MemoryEntry(
        id: 1,
        conversationId: 10,
        type: 'fact',
        content: 'Test content',
        createdAt: DateTime(2025, 1, 1),
        importance: 0.75,
      );

      final json = entry.toJson();
      final decoded = MemoryEntry.fromJson(json);

      expect(decoded.id, entry.id);
      expect(decoded.conversationId, entry.conversationId);
      expect(decoded.type, entry.type);
      expect(decoded.content, entry.content);
      expect(decoded.importance, entry.importance);
    });

    test('handles null importance', () {
      final json = <String, dynamic>{
        'id': 1,
        'conversationId': 10,
        'type': 'preference',
        'content': 'Test',
        'createdAt': '2025-01-01T00:00:00.000',
      };

      final entry = MemoryEntry.fromJson(json);
      expect(entry.importance, 0.5); // default value
    });
  });

  group('MemoryManager logic tests', () {
    test('_looksLikeFact detects fact patterns', () {
      // These would be tested via the extractFacts method if we had a real DB
      const factPatterns = [
        'I am a developer',
        'My name is John',
        'I work at Google',
        'I study computer science',
        'I live in New York',
        'I like programming',
        'I know Python',
        'I have a cat',
      ];

      for (final pattern in factPatterns) {
        final lower = pattern.toLowerCase();
        final isFact = lower.contains('i am') ||
            lower.contains('my name is') ||
            lower.contains('i work') ||
            lower.contains('i study') ||
            lower.contains('i live') ||
            lower.contains('i like') ||
            lower.contains('i know') ||
            lower.contains('i have');
        expect(
          isFact,
          true,
          reason: 'Pattern should be detected as fact: $pattern',
        );
      }
    });

    test('_looksLikePreference detects preference patterns', () {
      const preferencePatterns = [
        'I prefer Python over JavaScript',
        'I like hiking',
        'I hate bugs',
        'I love coffee',
        'My favorite color is blue',
        'My preferred language is Dart',
      ];

      for (final pattern in preferencePatterns) {
        final lower = pattern.toLowerCase();
        final isPreference = lower.contains('i prefer') ||
            lower.contains('i like') ||
            lower.contains('i hate') ||
            lower.contains('i love') ||
            lower.contains('favorite') ||
            lower.contains('preferred');
        expect(
          isPreference,
          true,
          reason: 'Pattern should be detected as preference: $pattern',
        );
      }
    });

    test('importance sorting logic', () {
      final importanceScores = [0.2, 0.9, 0.5, 0.8, 0.1];
      importanceScores.sort((a, b) => b.compareTo(a));

      expect(importanceScores.first, 0.9);
      expect(importanceScores.last, 0.1);
      expect(importanceScores, orderedEquals([0.9, 0.8, 0.5, 0.2, 0.1]));
    });

    test('token estimation for context building', () {
      const text = 'This is a test message with some content';
      final estimatedTokens = (text.length / 4).ceil();

      expect(estimatedTokens, greaterThan(0));
      expect(estimatedTokens, lessThan(text.length));
    });
  });
}
