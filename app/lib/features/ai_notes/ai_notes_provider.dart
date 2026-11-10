/// AI Notes feature - State management for AI-generated notes.
/// Integrates with Drift database, AI inference engine, and RAG service.
library;

import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/di.dart';
import '../../database/database.dart' as db;
import '../../ai/engine/ai_engine.dart';
import '../../ai/rag/rag_service.dart';
import 'ai_notes_prompts.dart';

/// Note model matching the Notes table.
class Note {
  final int id;
  final String title;
  final String content;
  final String? folder;
  final String? subject;
  final String? classLevel;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.folder,
    this.subject,
    this.classLevel,
    this.isPinned = false,
    required this.createdAt,
    required this.updatedAt,
    List<String>? tags,
  }) : tags = tags ?? [];

  Note copyWith({
    String? title,
    String? content,
    String? folder,
    String? subject,
    String? classLevel,
    bool? isPinned,
    DateTime? updatedAt,
    List<String>? tags,
  }) =>
      Note(
        id: id,
        title: title ?? this.title,
        content: content ?? this.content,
        folder: folder ?? this.folder,
        subject: subject ?? this.subject,
        classLevel: classLevel ?? this.classLevel,
        isPinned: isPinned ?? this.isPinned,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        tags: tags ?? this.tags,
      );

  /// Get word count from content.
  int get wordCount {
    if (content.isEmpty) return 0;
    return content.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
  }

  /// Get tags as comma-separated string for database storage.
  String get tagsString => tags.join(',');

  /// Create Note from database row.
  factory Note.fromDbRow(db.Note row) {
    List<String> tags = [];
    if (row.tags != null && row.tags!.isNotEmpty) {
      try {
        // Try parsing as JSON array first
        final decoded = jsonDecode(row.tags!);
        if (decoded is List) {
          tags = decoded.map((e) => e.toString()).toList();
        } else {
          // Fall back to comma-separated
          tags = row.tags!.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
        }
      } catch (_) {
        tags = row.tags!.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
      }
    }
    return Note(
      id: row.id,
      title: row.title,
      content: row.content,
      folder: row.folder,
      subject: row.subject,
      classLevel: row.classLevel,
      isPinned: row.isPinned,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      tags: tags,
    );
  }
}

/// State for AI Notes feature.
class AINotesState {
  final List<Note> notes;
  final String searchQuery;
  final bool isSearching;
  final bool isLoading;
  final bool isGenerating;
  final Note? currentNote;
  final String? error;
  final String? selectedFolder;
  final String? selectedTag;

  const AINotesState({
    this.notes = const [],
    this.searchQuery = '',
    this.isSearching = false,
    this.isLoading = false,
    this.isGenerating = false,
    this.currentNote,
    this.error,
    this.selectedFolder,
    this.selectedTag,
  });

  AINotesState copyWith({
    List<Note>? notes,
    String? searchQuery,
    bool? isSearching,
    bool? isLoading,
    bool? isGenerating,
    Note? currentNote,
    String? error,
    String? selectedFolder,
    String? selectedTag,
  }) {
    return AINotesState(
      notes: notes ?? this.notes,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      isLoading: isLoading ?? this.isLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      currentNote: currentNote ?? this.currentNote,
      error: error ?? this.error,
      selectedFolder: selectedFolder ?? this.selectedFolder,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}

/// Provider for AI Notes feature.
final aiNotesProvider = StateNotifierProvider<AINotesNotifier, AINotesState>(
  (ref) => AINotesNotifier(
    ref.watch(databaseProvider),
    ref.watch(ragServiceProvider),
    ref.watch(aiEngineProvider),
  ),
);

/// Notifier for AI Notes state management.
class AINotesNotifier extends StateNotifier<AINotesState> {
  final db.AppDatabase _database;
  final RAGService _ragService;
  final AIEngine _aiEngine;

  AINotesNotifier(this._database, this._ragService, this._aiEngine)
      : super(const AINotesState());

  /// Load all notes from database.
  Future<void> loadNotes() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final rows = await _database.select(_database.notes).get();
      final notes = rows.map((row) => Note.fromDbRow(row)).toList();
      
      // Sort by pinned first, then by updated date
      notes.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        return b.updatedAt.compareTo(a.updatedAt);
      });

      state = state.copyWith(notes: notes, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Load a single note by ID.
  Future<Note?> loadNote(int id) async {
    try {
      final rows = await (_database.select(_database.notes)
            ..where((n) => n.id.equals(id)))
          .get();
      if (rows.isEmpty) return null;
      return Note.fromDbRow(rows.first);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// Create a new empty note.
  Future<int?> createNote({
    String title = 'New Note',
    String content = '',
    String? folder,
    String? subject,
    String? classLevel,
    List<String>? tags,
  }) async {
    try {
      final now = DateTime.now();
      final companion = db.NotesCompanion(
        title: drift.Value(title),
        content: drift.Value(content),
        folder: folder != null ? drift.Value(folder) : const drift.Value.absent(),
        subject: subject != null ? drift.Value(subject) : const drift.Value.absent(),
        classLevel: classLevel != null ? drift.Value(classLevel) : const drift.Value.absent(),
        isPinned: const drift.Value(false),
        tags: tags != null ? drift.Value(tags.join(',')) : const drift.Value.absent(),
        createdAt: drift.Value(now),
        updatedAt: drift.Value(now),
      );

      final id = await _database.into(_database.notes).insert(companion);
      await loadNotes();
      return id;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// Update an existing note.
  Future<bool> updateNote({
    required int id,
    String? title,
    String? content,
    String? folder,
    String? subject,
    String? classLevel,
    bool? isPinned,
    List<String>? tags,
  }) async {
    try {
      final companion = db.NotesCompanion(
        title: title != null ? drift.Value(title) : const drift.Value.absent(),
        content: content != null ? drift.Value(content) : const drift.Value.absent(),
        folder: folder != null ? drift.Value(folder) : const drift.Value.absent(),
        subject: subject != null ? drift.Value(subject) : const drift.Value.absent(),
        classLevel: classLevel != null ? drift.Value(classLevel) : const drift.Value.absent(),
        isPinned: isPinned != null ? drift.Value(isPinned) : const drift.Value.absent(),
        tags: tags != null ? drift.Value(tags.join(',')) : const drift.Value.absent(),
        updatedAt: drift.Value(DateTime.now()),
      );

      await (_database.update(_database.notes)..where((n) => n.id.equals(id)))
          .write(companion);
      await loadNotes();
      
      // Update current note if it's the one being edited
      if (state.currentNote?.id == id) {
        final updatedNote = await loadNote(id);
        if (updatedNote != null) {
          state = state.copyWith(currentNote: updatedNote);
        }
      }
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Delete a note by ID.
  Future<bool> deleteNote(int id) async {
    try {
      await (_database.delete(_database.notes)..where((n) => n.id.equals(id))).go();
      if (state.currentNote?.id == id) {
        state = state.copyWith(currentNote: null);
      }
      await loadNotes();
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Toggle pin status of a note.
  Future<bool> togglePin(int id) async {
    try {
      final note = await loadNote(id);
      if (note == null) return false;
      return await updateNote(id: id, isPinned: !note.isPinned);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Set the current note for editing.
  void setCurrentNote(Note? note) {
    state = state.copyWith(currentNote: note);
  }

  /// Toggle search mode.
  void toggleSearch() {
    state = state.copyWith(
      isSearching: !state.isSearching,
      searchQuery: '',
    );
  }

  /// Search notes by title, content, or tags.
  void search(String query) {
    state = state.copyWith(searchQuery: query);
    
    if (query.isEmpty) {
      loadNotes();
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filtered = state.notes.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
          note.content.toLowerCase().contains(lowerQuery) ||
          note.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
    }).toList();

    state = state.copyWith(notes: filtered);
  }

  /// Filter notes by folder.
  void filterByFolder(String? folder) {
    state = state.copyWith(selectedFolder: folder);
    if (folder == null) {
      loadNotes();
      return;
    }
    final filtered = state.notes.where((note) => note.folder == folder).toList();
    state = state.copyWith(notes: filtered);
  }

  /// Filter notes by tag.
  void filterByTag(String? tag) {
    state = state.copyWith(selectedTag: tag);
    if (tag == null) {
      loadNotes();
      return;
    }
    final filtered = state.notes.where((note) => note.tags.contains(tag)).toList();
    state = state.copyWith(notes: filtered);
  }

  /// Get all unique folders from notes.
  List<String> getFolders() {
    final folders = state.notes
        .map((n) => n.folder)
        .where((f) => f != null && f.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    folders.sort();
    return folders;
  }

  /// Get all unique tags from notes.
  List<String> getTags() {
    final tags = <String>{};
    for (final note in state.notes) {
      tags.addAll(note.tags);
    }
    final tagList = tags.toList();
    tagList.sort();
    return tagList;
  }

  /// Generate notes from a topic description.
  Future<Note?> generateFromTopic({
    required String topicDescription,
    String noteType = 'study',
    String? folder,
    String? subject,
    String? classLevel,
    List<String>? tags,
  }) async {
    state = state.copyWith(isGenerating: true, error: null);
    try {
      final prompt = AiNotesPrompts.getPromptByType(noteType, topicDescription);
      
      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        systemPrompt: AiNotesPrompts.systemPrompt,
        maxTokens: 2048,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final content = buffer.toString().trim();
      if (content.isEmpty) {
        state = state.copyWith(isGenerating: false, error: 'Generated content is empty');
        return null;
      }

      // Create note with generated content
      final id = await createNote(
        title: 'Notes: ${topicDescription.length > 50 ? '${topicDescription.substring(0, 50)}...' : topicDescription}',
        content: content,
        folder: folder,
        subject: subject,
        classLevel: classLevel,
        tags: tags,
      );

      if (id == null) {
        state = state.copyWith(isGenerating: false);
        return null;
      }

      final note = await loadNote(id);
      state = state.copyWith(isGenerating: false, currentNote: note);
      return note;
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
      return null;
    }
  }

  /// Generate notes from a document using RAG.
  Future<Note?> generateFromDocument({
    required int documentId,
    String noteType = 'study',
    String? folder,
    String? subject,
    String? classLevel,
    List<String>? tags,
  }) async {
    state = state.copyWith(isGenerating: true, error: null);
    try {
      // Get document info
      final docRows = await (_database.select(_database.documents)
            ..where((d) => d.id.equals(documentId)))
          .get();
      
      if (docRows.isEmpty) {
        state = state.copyWith(isGenerating: false, error: 'Document not found');
        return null;
      }
      final doc = docRows.first;

      // Search for relevant chunks using RAG
      final searchResults = await _ragService.searchInDocument(
        'key concepts main ideas summary',
        documentId.toString(),
        limit: 10,
      );

      if (searchResults.isEmpty) {
        // Fall back to extracted text if RAG has no chunks
        if (doc.extractedText == null || doc.extractedText!.isEmpty) {
          state = state.copyWith(
            isGenerating: false,
            error: 'No content found in document',
          );
          return null;
        }
        
        final prompt = AiNotesPrompts.getPromptByType(
          noteType,
          doc.extractedText!,
        );
        
        final buffer = StringBuffer();
        await for (final chunk in _aiEngine.generate(
          prompt: prompt,
          history: [],
          systemPrompt: AiNotesPrompts.systemPrompt,
          maxTokens: 2048,
          temperature: 0.7,
          topP: 0.9,
        )) {
          buffer.write(chunk);
        }

        final content = buffer.toString().trim();
        final id = await createNote(
          title: 'Notes: ${doc.title}',
          content: content,
          folder: folder,
          subject: subject,
          classLevel: classLevel,
          tags: tags ?? ['document', 'auto-generated'],
        );

        if (id == null) {
          state = state.copyWith(isGenerating: false);
          return null;
        }

        final note = await loadNote(id);
        state = state.copyWith(isGenerating: false, currentNote: note);
        return note;
      }

      // Build context from search results
      final context = searchResults
          .map((r) => '[${r.chunk.chunkIndex + 1}] ${r.chunk.content}')
          .join('\n\n');

      final prompt = '''${AiNotesPrompts.getPromptByType(noteType, '')}

Context from document "${doc.title}":
$context

Generate comprehensive notes based on this content:''';

      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        systemPrompt: AiNotesPrompts.systemPrompt,
        maxTokens: 2048,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final content = buffer.toString().trim();
      final id = await createNote(
        title: 'Notes: ${doc.title}',
        content: content,
        folder: folder,
        subject: subject,
        classLevel: classLevel,
        tags: tags ?? ['document', 'auto-generated'],
      );

      if (id == null) {
        state = state.copyWith(isGenerating: false);
        return null;
      }

      final note = await loadNote(id);
      state = state.copyWith(isGenerating: false, currentNote: note);
      return note;
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
      return null;
    }
  }

  /// Generate notes from a video transcript.
  Future<Note?> generateFromVideoTranscript({
    required int resourceId,
    String noteType = 'summary',
    String? folder,
    String? subject,
    String? classLevel,
    List<String>? tags,
  }) async {
    state = state.copyWith(isGenerating: true, error: null);
    try {
      // Get video transcript
      final transcriptRows = await (_database.select(_database.videoTranscripts)
            ..where((vt) => vt.resourceId.equals(resourceId)))
          .get();

      if (transcriptRows.isEmpty) {
        state = state.copyWith(
          isGenerating: false,
          error: 'Video transcript not found',
        );
        return null;
      }
      final transcript = transcriptRows.first;

      // Get resource title if available
      String videoTitle = 'Video';
      try {
        final resourceRows = await (_database.select(_database.learningResources)
              ..where((lr) => lr.id.equals(resourceId)))
            .get();
        if (resourceRows.isNotEmpty) {
          videoTitle = resourceRows.first.title;
        }
      } catch (_) {}

      final prompt = AiNotesPrompts.getPromptByType(
        noteType,
        transcript.fullText,
      );

      final buffer = StringBuffer();
      await for (final chunk in _aiEngine.generate(
        prompt: prompt,
        history: [],
        systemPrompt: AiNotesPrompts.systemPrompt,
        maxTokens: 2048,
        temperature: 0.7,
        topP: 0.9,
      )) {
        buffer.write(chunk);
      }

      final content = buffer.toString().trim();
      if (content.isEmpty) {
        state = state.copyWith(isGenerating: false, error: 'Generated content is empty');
        return null;
      }

      final id = await createNote(
        title: 'Notes: $videoTitle',
        content: content,
        folder: folder,
        subject: subject,
        classLevel: classLevel,
        tags: tags ?? ['video', 'transcript', 'auto-generated'],
      );

      if (id == null) {
        state = state.copyWith(isGenerating: false);
        return null;
      }

      final note = await loadNote(id);
      state = state.copyWith(isGenerating: false, currentNote: note);
      return note;
    } catch (e) {
      state = state.copyWith(isGenerating: false, error: e.toString());
      return null;
    }
  }

  /// Clear error state.
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Cancel ongoing generation.
  void cancelGeneration() {
    _aiEngine.cancel();
    state = state.copyWith(isGenerating: false);
  }
}
