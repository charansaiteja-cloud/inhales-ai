import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollegeState {
  final String? selectedSubject;
  final String? selectedDifficulty;
  final List<String> subjects;
  final bool isLoading;

  const CollegeState({
    this.selectedSubject,
    this.selectedDifficulty = 'Intermediate',
    this.subjects = const [],
    this.isLoading = false,
  });
}

final collegeProvider = StateNotifierProvider<CollegeNotifier, CollegeState>(
  (ref) => CollegeNotifier(),
);

class CollegeNotifier extends StateNotifier<CollegeState> {
  CollegeNotifier()
      : super(
          const CollegeState(
            subjects: [
              'Engineering',
              'Computer Science',
              'Programming',
              'Mathematics',
              'Physics',
              'Chemistry',
              'Biology',
              'Commerce',
              'Accounting',
              'Economics',
              'Business Management',
              'Statistics',
              'Humanities',
            ],
          ),
        );

  Future<void> selectSubject(String subject) async {
    state = CollegeState(
      selectedSubject: subject,
      selectedDifficulty: state.selectedDifficulty,
      subjects: state.subjects,
    );
  }

  Future<void> selectDifficulty(String difficulty) async {
    state = CollegeState(
      selectedSubject: state.selectedSubject,
      selectedDifficulty: difficulty,
      subjects: state.subjects,
    );
  }
}
