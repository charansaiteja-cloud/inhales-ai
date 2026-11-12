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
    final notifier = ref.read(quizProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Quizzes'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: state.isInProgress
            ? _buildActiveQuiz(context, ref, state, notifier, isDark)
            : _buildQuizLibrary(context, ref, state, notifier, isDark),
      ),
    );
  }

  Widget _buildQuizLibrary(
    BuildContext context,
    WidgetRef ref,
    QuizState state,
    QuizNotifier notifier,
    bool isDark,
  ) {
    final categories = [
      {'name': 'Mathematics', 'icon': Icons.calculate_rounded},
      {'name': 'Science', 'icon': Icons.science_rounded},
      {'name': 'History', 'icon': Icons.history_edu_rounded},
      {'name': 'General Knowledge', 'icon': Icons.lightbulb_rounded},
      {'name': 'Programming', 'icon': Icons.code_rounded},
      {'name': 'Languages', 'icon': Icons.language_rounded},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Custom Quiz',
            style: InhaleTypography.headlineMedium.copyWith(
              color: isDark
                  ? InhaleColors.textPrimary
                  : InhaleColors.lightNavyText,
            ),
          ),
          const SizedBox(height: InhaleSpacing.sm),
          Text(
            'Enter a topic and generate AI-powered quizzes',
            style: InhaleTypography.bodyMedium.copyWith(
              color: isDark
                  ? InhaleColors.textSecondary
                  : InhaleColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: InhaleSpacing.md),
          GlassCard(
            padding: const EdgeInsets.all(InhaleSpacing.md),
            child: GlassTextField(
              hintText: 'Enter a topic for an AI-generated quiz...',
              onChanged: (v) => notifier.setTopic(v),
            ),
          ),
          const SizedBox(height: InhaleSpacing.md),
          GlassButton(
            width: double.infinity,
            label: state.isGenerating ? 'Generating...' : 'Generate Quiz',
            onTap: state.isGenerating ? null : () => notifier.generateQuiz(),
            glow: !state.isGenerating,
          ),
          const SizedBox(height: InhaleSpacing.xl),
          Text(
            'Quick Topics',
            style: InhaleTypography.headlineMedium.copyWith(
              color: isDark
                  ? InhaleColors.textPrimary
                  : InhaleColors.lightNavyText,
            ),
          ),
          const SizedBox(height: InhaleSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 110,
              crossAxisSpacing: InhaleSpacing.md,
              mainAxisSpacing: InhaleSpacing.md,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              return GlassCard(
                onTap: () =>
                    notifier.generateQuiz(topic: cat['name'] as String),
                padding: const EdgeInsets.all(InhaleSpacing.md),
                elevated: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? InhaleColors.electricBlue.withValues(
                                alpha: 0.2,
                              )
                            : InhaleColors.lightPrimaryBlue.withValues(
                                alpha: 0.15,
                              ),
                        borderRadius: BorderRadius.circular(InhaleRadius.md),
                      ),
                      child: Icon(
                        cat['icon'] as IconData,
                        color: isDark
                            ? InhaleColors.electricBlue
                            : InhaleColors.lightPrimaryBlue,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: InhaleSpacing.sm),
                    Text(
                      cat['name'] as String,
                      style: InhaleTypography.titleSmall.copyWith(
                        color: isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveQuiz(
    BuildContext context,
    WidgetRef ref,
    QuizState state,
    QuizNotifier notifier,
    bool isDark,
  ) {
    final question = state.questions[state.currentIndex];

    return Column(
      children: [
        // Progress Header
        Container(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question ${state.currentIndex + 1} of ${state.questions.length}',
                    style: InhaleTypography.titleSmall.copyWith(
                      color: isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InhaleSpacing.sm),
              LinearProgressIndicator(
                value: (state.currentIndex + 1) / state.questions.length,
                backgroundColor: isDark
                    ? InhaleColors.glassBorderSubtle
                    : InhaleColors.lightGlassBorderSubtle,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark
                      ? InhaleColors.electricBlue
                      : InhaleColors.lightPrimaryBlue,
                ),
                borderRadius: BorderRadius.circular(InhaleRadius.pill),
                minHeight: 4,
              ),
            ],
          ),
        ),

        // Question Card
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(InhaleSpacing.md),
            child: Column(
              children: [
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.lg),
                  elevated: true,
                  child: Text(
                    question.question,
                    style: InhaleTypography.titleMedium.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.lg),

                // Options
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 80,
                    crossAxisSpacing: InhaleSpacing.md,
                    mainAxisSpacing: InhaleSpacing.md,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final label = String.fromCharCode(65 + index);
                    return GlassCard(
                      onTap: () =>
                          notifier.submitAnswer(state.currentIndex, label),
                      padding: const EdgeInsets.all(InhaleSpacing.md),
                      elevated: true,
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? InhaleColors.electricBlue.withValues(
                                      alpha: 0.2,
                                    )
                                  : InhaleColors.lightPrimaryBlue
                                      .withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: isDark
                                      ? InhaleColors.electricBlue
                                      : InhaleColors.lightPrimaryBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: InhaleSpacing.md),
                          Expanded(
                            child: Text(
                              'Option $label',
                              style: InhaleTypography.bodyMedium.copyWith(
                                color: isDark
                                    ? InhaleColors.textPrimary
                                    : InhaleColors.lightNavyText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // End Quiz Button
        Padding(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: GlassButton(
                  label: 'End Quiz',
                  onTap: () => notifier.reset(),
                  outlined: true,
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
