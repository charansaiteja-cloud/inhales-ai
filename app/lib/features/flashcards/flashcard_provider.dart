/// Flashcard providers — Riverpod state management for flashcards,
/// decks, FSRS scheduling, and AI-powered card generation.
library;

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/di.dart';
import '../../../database/database.dart' as db;
import '../../../ai/engine/ai_engine.dart' as ai_engine;
import '../../../ai/rag/rag_service.dart';
import 'fsrs_algorithm.dart';

// ── Data Models ─────────────────────────────────────────────

/// A flashcard deck (collection of cards).
class FlashcardDeck {
  final int id;
  final String name;
  final String? description;
  final int? subjectId;
  final int? topicId;
  final String? sourceDocumentId;
  final int cardCount;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FlashcardDeck({
    required this.id,
    required this.name,
    this.description,
    this.subjectId,
    this.topicId,
    this.sourceDocumentId,
    this.cardCount = 0,
    this.isPublic = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FlashcardDeck.fromDb(db.FlashcardDeck data) {
    return FlashcardDeck(
      id: data.id,
      name: data.name,
      description: data.description,
      subjectId: data.subjectId,
      topicId: data.topicId,
      sourceDocumentId: data.sourceDocumentId,
      cardCount: data.cardCount,
      isPublic: data.isPublic,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}

/// An individual flashcard with FSRS state.
class Flashcard {
  final int id;
  final int deckId;
  final String front;
  final String back;
  final String? hint;
  final String? tags;
  final String? sourceChunkId;
  final double stability;
  final double difficulty;
  final int elapsedDays;
  final int scheduledDays;
  final DateTime? dueDate;
  final DateTime? lastReviewed;
  final int reviewCount;
  final int lapseCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Flashcard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
    this.hint,
    this.tags,
    this.sourceChunkId,
    this.stability = 0.0,
    this.difficulty = 0.0,
    this.elapsedDays = 0,
    this.scheduledDays = 0,
    this.dueDate,
    this.lastReviewed,
    this.reviewCount = 0,
    this.lapseCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isDue => dueDate == null || dueDate!.isBefore(DateTime.now());

  bool get isNew => reviewCount == 0;

  List<String> get tagList {
    if (tags == null || tags!.isEmpty) return [];
    try {
      return List<String>.from(jsonDecode(tags!));
    } catch (_) {
      return [tags!];
    }
  }

  factory Flashcard.fromDb(db.Flashcard data) {
    return Flashcard(
      id: data.id,
      deckId: data.deckId,
      front: data.front,
      back: data.back,
      hint: data.hint,
      tags: data.tags,
      sourceChunkId: data.sourceChunkId,
      stability: data.stability,
      difficulty: data.difficulty,
      elapsedDays: data.elapsedDays,
      scheduledDays: data.scheduledDays,
      dueDate: data.dueDate,
      lastReviewed: data.lastReviewed,
      reviewCount: data.reviewCount,
      lapseCount: data.lapseCount,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}

/// A review record for a flashcard.
class FlashcardReview {
  final int id;
  final int flashcardId;
  final int rating;
  final double stabilityBefore;
  final double difficultyBefore;
  final double stabilityAfter;
  final double difficultyAfter;
  final int elapsedDays;
  final int scheduledDays;
  final DateTime reviewedAt;

  const FlashcardReview({
    required this.id,
    required this.flashcardId,
    required this.rating,
    required this.stabilityBefore,
    required this.difficultyBefore,
    required this.stabilityAfter,
    required this.difficultyAfter,
    required this.elapsedDays,
    required this.scheduledDays,
    required this.reviewedAt,
  });

  factory FlashcardReview.fromDb(db.FlashcardReview data) {
    return FlashcardReview(
      id: data.id,
      flashcardId: data.flashcardId,
      rating: data.rating,
      stabilityBefore: data.stabilityBefore,
      difficultyBefore: data.difficultyBefore,
      stabilityAfter: data.stabilityAfter,
      difficultyAfter: data.difficultyAfter,
      elapsedDays: data.elapsedDays,
      scheduledDays: data.scheduledDays,
      reviewedAt: data.reviewedAt,
    );
  }
}

// ── State Models ────────────────────────────────────────────

class FlashcardState {
  final List<FlashcardDeck> decks;
  final Map<int, List<Flashcard>> deckCards;
  final List<Flashcard> dueCards;
  final int dailyGoal;
  final int todayReviews;
  final bool isLoading;
  final String? error;

  const FlashcardState({
    this.decks = const [],
    this.deckCards = const {},
    this.dueCards = const [],
    this.dailyGoal = 20,
    this.todayReviews = 0,
    this.isLoading = false,
    this.error,
  });

  FlashcardState copyWith({
    List<FlashcardDeck>? decks,
    Map<int, List<Flashcard>>? deckCards,
    List<Flashcard>? dueCards,
    int? dailyGoal,
    int? todayReviews,
    bool? isLoading,
    String? error,
  }) {
    return FlashcardState(
      decks: decks ?? this.decks,
      deckCards: deckCards ?? this.deckCards,
      dueCards: dueCards ?? this.dueCards,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      todayReviews: todayReviews ?? this.todayReviews,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  int get totalDue => dueCards.length;
  double get progress => dailyGoal > 0 ? (todayReviews / dailyGoal).clamp(0, 1) : 0;
}

// ── Providers ───────────────────────────────────────────────

final flashcardProvider =
    StateNotifierProvider<FlashcardNotifier, FlashcardState>(
  (ref) {
    final database = ref.watch(databaseProvider);
    final aiEngine = ref.watch(aiEngineProvider);
    final ragService = ref.watch(ragServiceProvider);
    return FlashcardNotifier(
      database: database,
      aiEngine: aiEngine,
      ragService: ragService,
    );
  },
);

final flashcardDecksProvider = Provider<List<FlashcardDeck>>((ref) {
  return ref.watch(flashcardProvider).decks;
});

final dueFlashcardsProvider = Provider<List<Flashcard>>((ref) {
  return ref.watch(flashcardProvider).dueCards;
});

final flashcardsProvider =
    Provider.family<List<Flashcard>, int>((ref, deckId) {
  final state = ref.watch(flashcardProvider);
  return state.deckCards[deckId] ?? [];
});

final dueCountProvider =
    Provider.family<int, int>((ref, deckId) {
  final cards = ref.watch(flashcardsProvider(deckId));
  return cards.where((c) => c.isDue).length;
});

// ── Notifier ────────────────────────────────────────────────

class FlashcardNotifier extends StateNotifier<FlashcardState> {
  final db.AppDatabase _database;
  final ai_engine.AIEngine _aiEngine;
  final RAGService _ragService;
  final FSRSParameters _fsrsParams;

  FlashcardNotifier({
    required db.AppDatabase database,
    required ai_engine.AIEngine aiEngine,
    required RAGService ragService,
  })  : _database = database,
        _aiEngine = aiEngine,
        _ragService = ragService,
        _fsrsParams = const FSRSParameters(),
        super(const FlashcardState()) {
    _loadAll();
  }

  // ── Load ───────────────────────────────────────────────

  Future<void> _loadAll() async {
    state = state.copyWith(isLoading: true);
    try {
      await _loadDecks();
      await _loadDueCards();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _loadDecks() async {
    final decks = await _database.select(_database.flashcardDecks).get();
    state = state.copyWith(
      decks: decks.map(FlashcardDeck.fromDb).toList(),
    );
  }

  Future<void> _loadDueCards() async {
    final now = DateTime.now();
    final raw = await _database.select(_database.flashcards).get();
    final cards = raw.map(Flashcard.fromDb).toList();
    final due = cards.where((c) => c.isDue).toList();

    // Load cards per deck
    final deckCards = <int, List<Flashcard>>{};
    for (final card in cards) {
      deckCards.putIfAbsent(card.deckId, () => []).add(card);
    }

    state = state.copyWith(
      dueCards: due,
      deckCards: deckCards,
    );
  }

  Future<void> loadCardsForDeck(int deckId) async {
    try {
      final raw = await (
        _database.select(_database.flashcards)
          ..where((t) => t.deckId.equals(deckId))
      ).get();
      final cards = raw.map(Flashcard.fromDb).toList();
      final updated = Map<int, List<Flashcard>>.from(state.deckCards);
      updated[deckId] = cards;
      state = state.copyWith(deckCards: updated);
    } catch (e) {
      state = state.copyWith(error: 'Failed to load deck: $e');
    }
  }

  // ── Deck CRUD ──────────────────────────────────────────

  Future<int> createDeck({
    required String name,
    String? description,
    int? subjectId,
    int? topicId,
    String? sourceDocumentId,
  }) async {
    try {
      final now = DateTime.now();
      final id = await _database.into(_database.flashcardDecks).insert(
        db.FlashcardDecksCompanion(
          name: drift.Value(name),
          description: drift.Value(description),
          subjectId: drift.Value(subjectId),
          topicId: drift.Value(topicId),
          sourceDocumentId: drift.Value(sourceDocumentId),
          cardCount: drift.Value(0),
          isPublic: drift.Value(false),
          createdAt: drift.Value(now),
          updatedAt: drift.Value(now),
        ),
      );
      await _loadDecks();
      return id;
    } catch (e) {
      state = state.copyWith(error: 'Failed to create deck: $e');
      rethrow;
    }
  }

  Future<void> updateDeck({
    required int id,
    String? name,
    String? description,
  }) async {
    try {
      await (_database.update(_database.flashcardDecks)
        ..where((t) => t.id.equals(id))).write(
        db.FlashcardDecksCompanion(
          name: drift.Value(name ?? _getDeckName(id)),
          description: drift.Value(description),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
      await _loadDecks();
    } catch (e) {
      state = state.copyWith(error: 'Failed to update deck: $e');
      rethrow;
    }
  }

  String _getDeckName(int id) {
    return state.decks
        .firstWhere((d) => d.id == id, orElse: () => throw StateError('Deck not found'))
        .name;
  }

  Future<void> deleteDeck(int id) async {
    try {
      await (_database.delete(_database.flashcardDecks)
        ..where((t) => t.id.equals(id))).go();
      final updated = Map<int, List<Flashcard>>.from(state.deckCards);
      updated.remove(id);
      state = state.copyWith(
        decks: state.decks.where((d) => d.id != id).toList(),
        deckCards: updated,
      );
      await _loadDueCards();
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete deck: $e');
      rethrow;
    }
  }

  // ── Card CRUD ──────────────────────────────────────────

  Future<int> createCard({
    required int deckId,
    required String front,
    required String back,
    String? hint,
    List<String>? tags,
    String? sourceChunkId,
  }) async {
    try {
      final now = DateTime.now();
      final id = await _database.into(_database.flashcards).insert(
        db.FlashcardsCompanion(
          deckId: drift.Value(deckId),
          front: drift.Value(front),
          back: drift.Value(back),
          hint: drift.Value(hint),
          tags: drift.Value(tags != null ? jsonEncode(tags) : null),
          sourceChunkId: drift.Value(sourceChunkId),
          stability: drift.Value(0.0),
          difficulty: drift.Value(0.0),
          elapsedDays: drift.Value(0),
          scheduledDays: drift.Value(0),
          dueDate: drift.Value(now),
          lastReviewed: drift.Value(null),
          reviewCount: drift.Value(0),
          lapseCount: drift.Value(0),
          createdAt: drift.Value(now),
          updatedAt: drift.Value(now),
        ),
      );

      // Update deck card count
      await (_database.update(_database.flashcardDecks)
        ..where((t) => t.id.equals(deckId))).write(
        db.FlashcardDecksCompanion(
          updatedAt: drift.Value(DateTime.now()),
        ),
      );

      await loadCardsForDeck(deckId);
      await _loadDueCards();
      return id;
    } catch (e) {
      state = state.copyWith(error: 'Failed to create card: $e');
      rethrow;
    }
  }

  Future<void> updateCard({
    required int id,
    String? front,
    String? back,
    String? hint,
    List<String>? tags,
  }) async {
    try {
      final card = _findCardById(id);
      final companion = db.FlashcardsCompanion(
        front: front != null ? drift.Value(front) : drift.Value.absent(),
        back: back != null ? drift.Value(back) : drift.Value.absent(),
        hint: hint != null ? drift.Value(hint) : drift.Value.absent(),
        tags: tags != null ? drift.Value(jsonEncode(tags)) : drift.Value.absent(),
        updatedAt: drift.Value(DateTime.now()),
      );
      await (_database.update(_database.flashcards)
        ..where((t) => t.id.equals(id))).write(companion);
      await loadCardsForDeck(card.deckId);
    } catch (e) {
      state = state.copyWith(error: 'Failed to update card: $e');
      rethrow;
    }
  }

  Future<void> deleteCard(int id) async {
    try {
      final card = _findCardById(id);
      await (_database.delete(_database.flashcards)
        ..where((t) => t.id.equals(id))).go();
      await loadCardsForDeck(card.deckId);
      await _loadDueCards();
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete card: $e');
      rethrow;
    }
  }

  Flashcard _findCardById(int id) {
    for (final cards in state.deckCards.values) {
      final found = cards.cast<Flashcard?>().firstWhere(
        (c) => c != null && c.id == id,
        orElse: () => null,
      );
      if (found != null) return found;
    }
    // Fall back to due cards
    return state.dueCards.firstWhere(
      (c) => c.id == id,
      orElse: () => throw StateError('Card not found'),
    );
  }

  // ── Review with FSRS ──────────────────────────────────

  Future<void> reviewFlashcard(int cardId, FlashcardRating rating) async {
    try {
      final card = _findCardById(cardId);
      final fsrsState = FSRSState(
        stability: card.stability,
        difficulty: card.difficulty,
        elapsedDays: card.elapsedDays,
        scheduledDays: card.scheduledDays,
        reviewCount: card.reviewCount,
        lapseCount: card.lapseCount,
        isNew: card.isNew,
      );

      final result = fsrsNext(fsrsState, rating, _fsrsParams);

      // Record the review
      await _database.into(_database.flashcardReviews).insert(
        db.FlashcardReviewsCompanion(
          flashcardId: drift.Value(cardId),
          rating: drift.Value(rating.value),
          stabilityBefore: drift.Value(card.stability),
          difficultyBefore: drift.Value(card.difficulty),
          stabilityAfter: drift.Value(result.stability),
          difficultyAfter: drift.Value(result.difficulty),
          elapsedDays: drift.Value(card.elapsedDays),
          scheduledDays: drift.Value(result.scheduledDays),
          reviewedAt: drift.Value(DateTime.now()),
        ),
      );

      // Update the card with new FSRS state
      final now = DateTime.now();
      await (_database.update(_database.flashcards)
        ..where((t) => t.id.equals(cardId))).write(
        db.FlashcardsCompanion(
          stability: drift.Value(result.stability),
          difficulty: drift.Value(result.difficulty),
          scheduledDays: drift.Value(result.scheduledDays),
          dueDate: drift.Value(result.dueDate),
          lastReviewed: drift.Value(now),
          reviewCount: drift.Value(result.reviewCount),
          lapseCount: drift.Value(result.lapseCount),
          updatedAt: drift.Value(now),
        ),
      );

      // Update counts
      state = state.copyWith(
        todayReviews: state.todayReviews + 1,
        dueCards: state.dueCards.where((c) => c.id != cardId).toList(),
      );

      await loadCardsForDeck(card.deckId);
    } catch (e) {
      state = state.copyWith(error: 'Review failed: $e');
      rethrow;
    }
  }

  // ── AI Flashcard Generation ────────────────────────────

  Future<int> generateFlashcardsFromTopic({
    required String topic,
    int count = 10,
    String? deckName,
  }) async {
    return _generateCards(
      deckName: deckName ?? 'Flashcards: $topic',
      content: topic,
      context: 'Generate $count flashcards about the topic: $topic',
    );
  }

  Future<int> generateFlashcardsFromDocument({
    required String documentId,
    int count = 10,
  }) async {
    try {
      // Search document for relevant chunks
      final results = await _ragService.searchInDocument(
        'key concepts summary',
        documentId,
        limit: 10,
      );

      final content = results
          .map((r) => r.chunk.content)
          .join('\n\n');

      if (content.isEmpty) {
        state = state.copyWith(error: 'No content found in document');
        return -1;
      }

      final deckName = 'Flashcards: Document $documentId';
      return _generateCards(
        deckName: deckName,
        content: content,
        context: 'Generate $count flashcards from this document content:',
        sourceDocumentId: documentId,
      );
    } catch (e) {
      state = state.copyWith(error: 'Failed to generate from document: $e');
      return -1;
    }
  }

  Future<int> generateFlashcardsFromText({
    required String text,
    int count = 10,
    String? deckName,
  }) async {
    return _generateCards(
      deckName: deckName ?? 'Custom Flashcards',
      content: text,
      context: 'Generate $count flashcards from this text:',
    );
  }

  Future<int> _generateCards({
    required String deckName,
    required String content,
    required String context,
    String? sourceDocumentId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final prompt = '''$context

Output a JSON array ONLY (no markdown, no code blocks):
[
  {"front": "question or prompt", "back": "answer or explanation", "hint": "optional hint"},
  ...
]

Content:
$content''';

      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        systemPrompt: 'You are a flashcard generator. Output valid JSON array only.',
        maxTokens: 2048,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final cards = _parseFlashcards(buffer.toString());

      // Create deck
      final deckId = await createDeck(
        name: deckName,
        description: 'AI-generated flashcards',
        sourceDocumentId: sourceDocumentId,
      );

      // Create cards in deck
      for (final card in cards) {
        await createCard(
          deckId: deckId,
          front: card.front,
          back: card.back,
          hint: card.hint,
        );
      }

      await _loadDecks();
      state = state.copyWith(isLoading: false);
      return deckId;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Generation failed: $e',
      );
      return -1;
    }
  }

  List<({String front, String back, String? hint})> _parseFlashcards(String response) {
    final results = <({String front, String back, String? hint})>[];
    try {
      // Strip markdown code blocks if present
      var cleaned = response.trim();
      if (cleaned.startsWith('```')) {
        final lines = cleaned.split('\n');
        cleaned = lines.skip(1).take(lines.length - 2).join('\n').trim();
      }

      final parsed = jsonDecode(cleaned) as List;
      for (final item in parsed) {
        if (item is Map && item['front'] != null && item['back'] != null) {
          results.add((
            front: item['front'].toString(),
            back: item['back'].toString(),
            hint: item['hint']?.toString(),
          ));
        }
      }
    } catch (e) {
      // Fallback: parse line-by-line
      final lines = response.split('\n');
      String? currentFront;
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.startsWith('Q:') || trimmed.startsWith('Question:')) {
          currentFront = trimmed.substring(2).trim();
        } else if ((trimmed.startsWith('A:') || trimmed.startsWith('Answer:')) && currentFront != null) {
          results.add((
            front: currentFront,
            back: trimmed.substring(2).trim(),
            hint: null,
          ));
          currentFront = null;
        }
      }
    }

    // Final fallback
    if (results.isEmpty) {
      results.add((
        front: 'Generated flashcard from content',
        back: response.substring(0, response.length.clamp(0, 500)),
        hint: null,
      ));
    }

    return results;
  }

  // ── Daily goal management ─────────────────────────────

  void setDailyGoal(int goal) {
    state = state.copyWith(dailyGoal: goal);
  }

  void resetDailyProgress() {
    state = state.copyWith(todayReviews: 0);
  }
}
