import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'quiz_provider.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider);
    return Scaffold(
      appBar: GlassAppBar(title: 'Quizzes'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: state.isInProgress
            ? _buildActiveQuiz(context, ref, state)
            : _buildQuizLibrary(context, ref, state),
      ),
    );
  }

  Widget _buildQuizLibrary(BuildContext context, WidgetRef ref, QuizState state) {
    final categories = [
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded},
      {'name': 'Science', 'icon': Icons.science_rounded},
      {'name': 'History', 'icon': Icons.history_edu_rounded},
      {'name': 'General Knowledge', 'icon': Icons.lightbulb_rounded},
      {'name': 'Programming', 'icon': Icons.code_rounded},
      {'name': 'Languages', 'icon': Icons.language_rounded},
    ];
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                sliver: SliverToBoxAdapter(child: Text('Create Custom Quiz', style: InhaleTypography.headlineMedium)),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: GlassTextField(
                    hintText: 'Enter a topic for an AI-generated quiz...',
                    onChanged: (v) => ref.read(quizProvider.notifier).setTopic(v),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: GlassButton(
                    width: double.infinity,
                    label: state.isGenerating ? 'Generating...' : 'Generate Quiz',
                    onTap: state.isGenerating ? null : () => ref.read(quizProvider.notifier).generateQuiz(),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                sliver: SliverToBoxAdapter(child: Text('Quick Topics', style: InhaleTypography.headlineMedium)),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 90, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final cat = categories[index];
                    return GlassCard(
                      onTap: () => ref.read(quizProvider.notifier).generateQuiz(topic: cat['name']!),
                      padding: EdgeInsets.all(InhaleSpacing.md),
                      child: Column(
                        MainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], color: InhaleColors.primaryBlue, size: 28),
                          const SizedBox(height: 4),
                          Text(cat['name']!, style: InhaleTypography.titleSmall, textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  }, childCount: categories.length),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActiveQuiz(BuildContext context, WidgetRef ref, QuizState state) {
    final question = state.questions[state.currentIndex];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Question ${state.currentIndex + 1} / ${state.questions.length}', style: InhaleTypography.titleSmall),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                sliver: SliverToBoxAdapter(
                  child: GlassCard(
                    padding: EdgeInsets.all(InhaleSpacing.md),
                    child: Text(question.question, style: InhaleTypography.titleMedium),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 80, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final label = String.fromCharCode(65 + index);
                    return GlassCard(
                      onTap: () => ref.read(quizProvider.notifier).submitAnswer(state.currentIndex, label),
                      padding: EdgeInsets.all(InhaleSpacing.md),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(color: InhaleColors.primaryBlue.withAlpha(40), shape: BoxShape.circle),
                            child: Center(child: Text(label, style: const TextStyle(color: InhaleColors.primaryBlue, fontWeight: FontWeight.bold))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text('Option $label', style: InhaleTypography.bodyMedium)),
                        ],
                      ),
                    );
                  }, childCount: 4),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: GlassButton(
                  label: 'End Quiz',
                  onTap: () => ref.read(quizProvider.notifier).reset(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: InhaleSpacing.md),
      ],
    );
  }
}