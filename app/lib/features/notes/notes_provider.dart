import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  const Note({
    required this.id,
    required this.title,
    required this.content,
    this.folder,
    this.subject,
    this.classLevel,
    this.isPinned = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    String? title,
    String? content,
    String? folder,
    String? subject,
    String? classLevel,
    bool? isPinned,
    DateTime? updatedAt,
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
      );
}

class NotesState {
  final List<Map<String, dynamic>> notes;
  final String searchQuery;
  final bool isSearching;
  final Map<String, dynamic>? currentNote;

  const NotesState({
    this.notes = const [],
    this.searchQuery = '',
    this.isSearching = false,
    this.currentNote,
  });
}

final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>(
  (ref) => NotesNotifier(),
);

class NotesNotifier extends StateNotifier<NotesState> {
  int _nextId = 1;

  NotesNotifier() : super(const NotesState());

  void addNote() {
    final note = {
      'id': _nextId++,
      'title': 'New Note',
      'content': '',
      'createdAt': DateTime.now(),
    };
    state = NotesState(
      notes: [note, ...state.notes],
      searchQuery: state.searchQuery,
      isSearching: state.isSearching,
    );
  }

  void openNote(int index) {
    // Navigate to edit screen in full implementation
  }

  void deleteNote(int index) {
    final newNotes = List<Map<String, dynamic>>.from(state.notes);
    if (index >= 0 && index < newNotes.length) {
      newNotes.removeAt(index);
    }
    state = NotesState(
      notes: newNotes,
      searchQuery: state.searchQuery,
      isSearching: state.isSearching,
    );
  }

  void toggleSearch() {
    state = NotesState(
      notes: state.notes,
      searchQuery: '',
      isSearching: !state.isSearching,
    );
  }

  void search(String query) {
    state = NotesState(
      notes: state.notes,
      searchQuery: query,
      isSearching: state.isSearching,
    );
  }
}
