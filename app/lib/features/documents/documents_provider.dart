import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../../di/di.dart';
import '../../database/database.dart' as db;
import '../../ai/rag/rag_service.dart';

class DocumentsState {
  final List<DocumentItem> documents;
  final String searchQuery;
  final bool isLoading;
  final String? error;

  const DocumentsState({
    this.documents = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
  });

  DocumentsState copyWith({
    List<DocumentItem>? documents,
    String? searchQuery,
    bool? isLoading,
    String? error,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DocumentItem {
  final int id;
  final String title;
  final String filePath;
  final String fileType;
  final int sizeBytes;
  final DateTime importedAt;
  final String? summary;

  const DocumentItem({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.sizeBytes,
    required this.importedAt,
    this.summary,
  });
}

final documentsProvider =
    StateNotifierProvider<DocumentsNotifier, DocumentsState>(
      (ref) => DocumentsNotifier(
        ref.watch(databaseProvider),
        ref.watch(ragServiceProvider),
      ),
    );

class DocumentsNotifier extends StateNotifier<DocumentsState> {
  final db.AppDatabase _database;
  final RAGService _ragService;

  DocumentsNotifier(this._database, this._ragService)
    : super(const DocumentsState());

  Future<void> loadDocuments() async {
    state = state.copyWith(isLoading: true);
    try {
      final docs = await _database.select(_database.documents).get();
      state = DocumentsState(
        documents:
            docs
                .map(
                  (d) => DocumentItem(
                    id: d.id,
                    title: d.title,
                    filePath: d.filePath,
                    fileType: d.fileType,
                    sizeBytes: d.sizeBytes,
                    importedAt: d.importedAt,
                    summary: d.summary,
                  ),
                )
                .toList(),
      );
    } catch (e) {
      state = DocumentsState(error: e.toString());
    }
  }

  Future<void> importDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'md', 'txt'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    state = state.copyWith(isLoading: true);

    try {
      final content = await _readFileContent(file.path!);

      await _database
          .into(_database.documents)
          .insert(
            db.DocumentsCompanion(
              title: drift.Value(file.name),
              filePath: drift.Value(file.path!),
              fileType: drift.Value(file.name.split('.').last.toLowerCase()),
              sizeBytes: drift.Value(file.size),
              extractedText: drift.Value(content),
              importedAt: drift.Value(DateTime.now()),
            ),
          );

      await _ragService.addDocument(
        documentId: file.path!,
        title: file.name,
        content: content,
      );

      await loadDocuments();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<String> _readFileContent(String path) async {
    final file = File(path);
    if (!await file.exists()) throw Exception('File not found');

    final ext = path.split('.').last.toLowerCase();
    if (ext == 'pdf') {
      return 'PDF content extraction pending — use a PDF library for production';
    }

    return await file.readAsString();
  }

  void search(String query) {
    state = DocumentsState(
      documents:
          state.documents.where((d) {
            return d.title.toLowerCase().contains(query.toLowerCase());
          }).toList(),
      searchQuery: query,
    );
  }

  Future<void> deleteDocument(int id) async {
    await (_database.delete(_database.documents)
      ..where((d) => d.id.equals(id))).go();
    await loadDocuments();
  }
}
