import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exam_prep_provider.dart';

class ExamPrepScreen extends ConsumerWidget {
  const ExamPrepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examSchedules = ref.watch(examSchedulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Prep'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: examSchedules.length,
              itemBuilder: (context, index) {
                final exam = examSchedules[index];
                return Card(
                  child: ListTile(
                    title: Text(exam.name),
                    subtitle: Text('${exam.subject} - ${exam.examType}'),
                    trailing: Text(ref.read(examSchedulesProvider.notifier).examCountdown(exam.id)),
                    onTap: () {
                      _showExamDetailDialog(context, ref, exam);
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _showCreateExamDialog(context, ref);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _showCreateExamDialog(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _subjectController = TextEditingController();
    final _examTypeController = TextEditingController();
    final _examDateController = TextEditingController();
    final _targetScoreController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Exam Schedule'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Exam Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter exam name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'Subject'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subject';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _examTypeController,
                    decoration: const InputDecoration(labelText: 'Exam Type'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter exam type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _examDateController,
                    decoration: const InputDecoration(labelText: 'Exam Date (YYYY-MM-DD)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter exam date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _targetScoreController,
                    decoration: const InputDecoration(labelText: 'Target Score'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter target score';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ref.read(examSchedulesProvider.notifier).createExamSchedule(
                    name: _nameController.text,
                    subject: _subjectController.text,
                    examType: _examTypeController.text,
                    examDate: DateTime.parse(_examDateController.text),
                    targetScore: int.parse(_targetScoreController.text),
                  );
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showExamDetailDialog(BuildContext context, WidgetRef ref, ExamSchedule exam) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(exam.name),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject: ${exam.subject}'),
                Text('Type: ${exam.examType}'),
                Text('Date: ${exam.examDate.toLocal().toString()}'),
                Text('Target Score: ${exam.targetScore}'),
                const SizedBox(height: 20),
                Text('Readiness: ${ref.read(examSchedulesProvider.notifier).examReadiness(exam.id)}%'),
                const SizedBox(height: 20),
                FutureBuilder<
                  String>(
                  future: ref.read(examSchedulesProvider.notifier).generateRecommendations(exam.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Text('Recommendations: ${snapshot.data}');
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}