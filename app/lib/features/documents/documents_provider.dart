import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsState {
  final List<Map<String, dynamic>> documents;
  final String searchQuery;

  const DocumentsState({this.documents = const [], this.searchQuery = ''});
}

final documentsProvider = StateNotifierProvider<DocumentsNotifier, DocumentsState>(
  (ref) => DocumentsNotifier(),
);

class DocumentsNotifier extends StateNotifier<DocumentsState> {
  int _nextId = 1;

  DocumentsNotifier() : super(const DocumentsState());

  void addDocument() {
    final doc = {'id': _nextId++, 'name': 'New Document', 'type': 'PDF'};
    state = DocumentsState(documents: [doc, ...state.documents], searchQuery: state.searchQuery);
  }

  void openDocument(int index) {}

  void search(String query) {
    state = DocumentsState(documents: state.documents, searchQuery: query);
  }
}
