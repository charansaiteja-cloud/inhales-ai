import 'package:flutter_riverpod/flutter_riverpod.dart';

class PresentationState {
  final List<Map<String, dynamic>> presentations;
  final Map<String, dynamic>? currentPresentation;

  const PresentationState({this.presentations = const [], this.currentPresentation});
}

final presentationProvider = StateNotifierProvider<PresentationNotifier, PresentationState>(
  (ref) => PresentationNotifier(),
);

class PresentationNotifier extends StateNotifier<PresentationState> {
  PresentationNotifier() : super(const PresentationState());

  void showTopicInput() {
    final pres = {
      'title': 'New Presentation',
      'slides': 5,
      'createdAt': DateTime.now(),
    };
    state = PresentationState(presentations: [pres, ...state.presentations]);
  }

  void openPresentation(int index) {
    if (index >= 0 && index < state.presentations.length) {
      state = PresentationState(
        presentations: state.presentations,
        currentPresentation: state.presentations[index],
      );
    }
  }
}
