import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../di/di.dart';
import '../../database/database.dart' as db;
import '../../ai/rag/rag_service.dart';

class DocumentsState {
  final List<DocumentItem> documents;
  final String searchQuery;
  final bool isLoading;
  final String? error;
  final Set<int> selectedDocumentIds; // Multi-document selection
  final bool isMultiSelectMode;

  const DocumentsState({
    this.documents = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.error,
    this.selectedDocumentIds = const {},
    this.isMultiSelectMode = false,
  });

  DocumentsState copyWith({
    List<DocumentItem>? documents,
    String? searchQuery,
    bool? isLoading,
    String? error,
    Set<int>? selectedDocumentIds,
    bool? isMultiSelectMode,
  }) {
    return DocumentsState(
      documents: documents ?? this.documents,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedDocumentIds: selectedDocumentIds ?? this.selectedDocumentIds,
      isMultiSelectMode: isMultiSelectMode ?? this.isMultiSelectMode,
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
      final result = await _readFileContent(file.path!);

      await _database
          .into(_database.documents)
          .insert(
            db.DocumentsCompanion(
              title: drift.Value(file.name),
              filePath: drift.Value(file.path!),
              fileType: drift.Value(file.name.split('.').last.toLowerCase()),
              sizeBytes: drift.Value(file.size),
              extractedText: drift.Value(result.text),
              importedAt: drift.Value(DateTime.now()),
            ),
          );

      await _ragService.addDocument(
        documentId: file.path!,
        title: file.name,
        content: result.text,
        pageBreaks: result.pageBreaks,
      );

      await loadDocuments();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<({String text, List<int>? pageBreaks})> _readFileContent(
    String path,
  ) async {
    final file = File(path);
    if (!await file.exists()) throw Exception('File not found');

    final ext = path.split('.').last.toLowerCase();
    if (ext == 'pdf') {
      final result = await _extractPdfText(path);
      return (text: result.text, pageBreaks: result.pageBreaks);
    }

    return (text: await file.readAsString(), pageBreaks: null);
  }

  /// Extract text from a PDF using Syncfusion — page-aware, reliable,
  /// handles encrypted/scanned PDFs with explicit error messages.
  Future<({String text, List<int> pageBreaks})> _extractPdfText(
    String path,
  ) async {
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('PDF file not found: $path');
    }

    final bytes = await file.readAsBytes();
    PdfDocument document = PdfDocument(inputBytes: bytes);

    try {
      final pageCount = document.pages.count;
      if (pageCount == 0) {
        throw Exception('PDF has no pages');
      }

      final extractor = PdfTextExtractor(document);
      final buffer = StringBuffer();
      final pageBreaks = <int>[0];

      // Extract text page-by-page
      for (int i = 0; i < pageCount; i++) {
        final pageText = extractor.extractText(
          startPageIndex: i,
          endPageIndex: i,
        );

        if (pageText.trim().isNotEmpty) {
          if (i > 0) {
            pageBreaks.add(buffer.length);
          }
          buffer.writeln('--- Page ${i + 1} ---');
          buffer.writeln(pageText.trim());
          buffer.writeln();
        }
      }

      final result = buffer.toString().trim();
      if (result.isEmpty) {
        throw Exception(
          'PDF contains no extractable text (scanned images or encrypted)',
        );
      }

      return (text: result, pageBreaks: pageBreaks);
    } finally {
      document.dispose();
    }
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

  /// Toggle multi-select mode.
  void toggleMultiSelectMode() {
    state = state.copyWith(
      isMultiSelectMode: !state.isMultiSelectMode,
      selectedDocumentIds:
          state.isMultiSelectMode ? {} : state.selectedDocumentIds,
    );
  }

  /// Toggle selection of a document.
  void toggleSelection(int id) {
    final selected = Set<int>.from(state.selectedDocumentIds);
    if (selected.contains(id)) {
      selected.remove(id);
    } else {
      selected.add(id);
    }
    state = state.copyWith(selectedDocumentIds: selected);
  }

  /// Clear selection.
  void clearSelection() {
    state = state.copyWith(selectedDocumentIds: {}, isMultiSelectMode: false);
  }

  /// Delete selected documents and clean up their RAG chunks.
  Future<void> deleteSelectedDocuments() async {
    final ids = state.selectedDocumentIds.toList();
    if (ids.isEmpty) return;

    state = state.copyWith(isLoading: true);
    try {
      for (final id in ids) {
        await (_database.delete(_database.documents)
          ..where((d) => d.id.equals(id))).go();
      }

      // Clean up RAG chunks for deleted documents
      final paths =
          state.documents
              .where((d) => ids.contains(d.id))
              .map((d) => d.filePath)
              .toList();
      await _ragService.deleteDocuments(paths);

      clearSelection();
      await loadDocuments();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteDocument(int id) async {
    state = state.copyWith(isLoading: true);
    try {
      await (_database.delete(_database.documents)
        ..where((d) => d.id.equals(id))).go();

      // Clean up RAG chunks
      final doc = state.documents.firstWhere(
        (d) => d.id == id,
        orElse:
            () => DocumentItem(
              id: id,
              title: '',
              filePath: '',
              fileType: '',
              sizeBytes: 0,
              importedAt: DateTime.now(),
            ),
      );
      await _ragService.deleteDocument(doc.filePath);

      await loadDocuments();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  /// Generate an extractive summary for a document (no AI engine needed).
  String summarizeDocument(String content, {int maxSentences = 5}) {
    return _ragService.extractiveSummary(content, maxSentences: maxSentences);
  }

  /// Extract key topics from document content.
  List<String> extractTopics(String content, {int maxTopics = 7}) {
    return _ragService.extractKeyTopics(content, maxTopics: maxTopics);
  }

  /// Suggest questions based on document content.
  List<String> suggestQuestions(String content, {int maxQuestions = 5}) {
    return _ragService.suggestQuestions(content, maxQuestions: maxQuestions);
  }
}
