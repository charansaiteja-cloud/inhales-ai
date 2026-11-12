import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ai/engine/ffi_inference_engine.dart';

final examSchedulesProvider =
    StateNotifierProvider<ExamSchedulesNotifier, List<ExamSchedule>>((ref) {
  return ExamSchedulesNotifier();
});

class ExamSchedulesNotifier extends StateNotifier<List<ExamSchedule>> {
  ExamSchedulesNotifier() : super([]);

  Future<void> createExamSchedule({
    required String name,
    required String subject,
    required String examType,
    required DateTime examDate,
    required int targetScore,
  }) async {
    final newExam = ExamSchedule(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      subject: subject,
      examType: examType,
      examDate: examDate,
      targetScore: targetScore,
    );

    state = [...state, newExam];
  }

  String examCountdown(String examId) {
    final exam = state.firstWhere((exam) => exam.id == examId);
    final difference = exam.examDate.difference(DateTime.now());
    return '${difference.inDays} days remaining';
  }

  int examReadiness(String examId) {
    // Simplified readiness score calculation
    final exam = state.firstWhere((exam) => exam.id == examId);
    final difference = exam.examDate.difference(DateTime.now()).inDays;
    return (100 - (difference.abs() * 2)).clamp(0, 100).toInt();
  }

  Future<String> generateRecommendations(String examId) async {
    final exam = state.firstWhere((exam) => exam.id == examId);
    final inferenceEngine = FfiInferenceEngine();
    await inferenceEngine.init();
    final prompt =
        'Generate study recommendations for ${exam.subject} (${exam.examType}), target score: ${exam.targetScore}, exam date: ${exam.examDate.toLocal()}';
    final response = await inferenceEngine.generate(prompt).join();
    return response;
  }
}

class ExamSchedule {
  final String id;
  final String name;
  final String subject;
  final String examType;
  final DateTime examDate;
  final int targetScore;

  ExamSchedule({
    required this.id,
    required this.name,
    required this.subject,
    required this.examType,
    required this.examDate,
    required this.targetScore,
  });
}
