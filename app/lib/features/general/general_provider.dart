import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralState {
  final String? selectedCategory;
  final List<String> categories;

  const GeneralState({
    this.selectedCategory,
    this.categories = const [],
  });
}

final generalProvider = StateNotifierProvider<GeneralNotifier, GeneralState>(
  (ref) => GeneralNotifier(),
);

class GeneralNotifier extends StateNotifier<GeneralState> {
  GeneralNotifier() : super(const GeneralState(
    categories: [
      'General Knowledge', 'History', 'Geography', 'Science',
      'Technology', 'Space', 'Astronomy', 'Environment',
      'Languages', 'Career Guidance', 'Interview Preparation',
      'Productivity', 'Skill Development', 'Problem Solving',
    ],
  ));

  Future<void> selectCategory(String category) async {
    state = GeneralState(
      selectedCategory: category,
      categories: state.categories,
    );
  }
}
