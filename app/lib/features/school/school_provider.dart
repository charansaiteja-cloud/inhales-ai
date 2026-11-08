import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolState {
  final int selectedClass;
  final String? selectedSubject;
  final String? selectedTopic;
  final List<SchoolSubject> subjects;
  final bool isLoading;

  const SchoolState({
    this.selectedClass = 1,
    this.selectedSubject,
    this.selectedTopic,
    this.subjects = const [],
    this.isLoading = false,
  });
}

class SchoolSubject {
  final String name;
  final String icon;
  final List<SchoolChapter> chapters;

  const SchoolSubject({
    required this.name,
    required this.icon,
    this.chapters = const [],
  });
}

class SchoolChapter {
  final String title;
  final String? description;
  final List<String> topics;

  const SchoolChapter({
    required this.title,
    this.description,
    this.topics = const [],
  });
}

final schoolProvider = StateNotifierProvider<SchoolNotifier, SchoolState>(
  (ref) => SchoolNotifier(),
);

class SchoolNotifier extends StateNotifier<SchoolState> {
  SchoolNotifier() : super(const SchoolState(
    subjects: [
      SchoolSubject(name: 'Mathematics', icon: '📐'),
      SchoolSubject(name: 'Science', icon: '🔬'),
      SchoolSubject(name: 'English', icon: '📖'),
      SchoolSubject(name: 'Social Studies', icon: '🌍'),
      SchoolSubject(name: 'General Knowledge', icon: '🧠'),
    ],
  ));

  Future<void> selectClass(int cls) async {
    state = SchoolState(
      selectedClass: cls,
      selectedSubject: state.selectedSubject,
      selectedTopic: state.selectedTopic,
      subjects: state.subjects,
    );
  }

  Future<void> selectSubject(String subject) async {
    state = SchoolState(
      selectedClass: state.selectedClass,
      selectedSubject: subject,
      selectedTopic: state.selectedTopic,
      subjects: state.subjects,
    );
  }

  Future<void> selectTopic(String topic) async {
    state = SchoolState(
      selectedClass: state.selectedClass,
      selectedSubject: state.selectedSubject,
      selectedTopic: topic,
      subjects: state.subjects,
    );
  }
}
