import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'writing_provider.dart';

class WritingScreen extends ConsumerWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(writingProvider);
    final notifier = ref.read(writingProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final modes = [
      WritingMode.essay,
      WritingMode.letter,
      WritingMode.email,
      WritingMode.report,
      WritingMode.story,
      WritingMode.poem,
      WritingMode.speech,
      WritingMode.resume,
      WritingMode.article,
      WritingMode.social,
    ];
    final modeLabels = {
      WritingMode.essay: 'Essay',
      WritingMode.letter: 'Letter',
      WritingMode.email: 'Email',
      WritingMode.report: 'Report',
      WritingMode.story: 'Story',
      WritingMode.poem: 'Poem',
      WritingMode.speech: 'Speech',
      WritingMode.resume: 'Resume',
      WritingMode.article: 'Article',
      WritingMode.social: 'Social Post',
    };

    return Scaffold(
      appBar: GlassAppBar(title: 'Writing Assistant'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Writing Mode',
                style: InhaleTypography.headlineMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              Wrap(
                spacing: InhaleSpacing.sm,
                runSpacing: InhaleSpacing.sm,
                children: modes.map((m) {
                  final selected = m == state.mode;
                  return GlassCard(
                    onTap: () => notifier.setMode(m),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevated: selected,
                    glow: selected,
                    child: Text(
                      modeLabels[m]!,
                      style: InhaleTypography.labelMedium.copyWith(
                        color: selected
                            ? Colors.white
                            : (isDark
                                ? InhaleColors.electricBlue
                                : InhaleColors.lightPrimaryBlue),
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              Text(
                'Instructions',
                style: InhaleTypography.titleMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  maxLines: 3,
                  hintText: 'Describe what you want to write...',
                  onChanged: (v) => notifier.setInstructions(v),
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              Text(
                'Content',
                style: InhaleTypography.titleMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  maxLines: 15,
                  minLines: 10,
                  hintText: 'Your content will appear here...',
                  onChanged: (v) => notifier.setContent(v),
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              GlassButton(
                width: double.infinity,
                label:
                    state.isGenerating ? 'Generating...' : 'Generate Content',
                onTap: state.isGenerating
                    ? null
                    : () => notifier.generateContent(),
                glow: !state.isGenerating,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
