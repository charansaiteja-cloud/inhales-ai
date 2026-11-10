import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'presentation_provider.dart';

class PresentationScreen extends ConsumerWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(presentationProvider);
    final notifier = ref.read(presentationProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Presentations'),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child:
            state.isGenerating
                ? const Center(child: CircularProgressIndicator())
                : state.presentations.isEmpty
                ? _buildEmptyState(context, notifier, isDark)
                : _buildPresentationsList(
                  context,
                  ref,
                  state,
                  notifier,
                  isDark,
                ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    PresentationNotifier notifier,
    bool isDark,
  ) {
    final topicController = TextEditingController();
    final slidesController = TextEditingController(text: '5');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(InhaleSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? InhaleColors.electricBlue.withValues(alpha: 0.15)
                        : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.slideshow_rounded,
                size: 64,
                color:
                    isDark
                        ? InhaleColors.electricBlue
                        : InhaleColors.lightPrimaryBlue,
              ),
            ),
            const SizedBox(height: InhaleSpacing.lg),
            Text(
              'No Presentations Yet',
              style: InhaleTypography.headlineMedium.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Text(
              'Create a presentation from a topic or generate one with AI',
              style: InhaleTypography.bodyMedium.copyWith(
                color:
                    isDark
                        ? InhaleColors.textSecondary
                        : InhaleColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: InhaleSpacing.lg),
            GlassTextField(
              controller: topicController,
              hintText: 'Enter topic...',
            ),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(
              controller: slidesController,
              hintText: 'Number of slides (default 5)',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: InhaleSpacing.lg),
            GlassButton(
              width: 240,
              label: 'Generate with AI',
              onTap: () {
                final topic = topicController.text.trim();
                if (topic.isNotEmpty) {
                  final slides =
                      int.tryParse(slidesController.text.trim()) ?? 5;
                  notifier.generatePresentation(topic, slides: slides);
                }
              },
              glow: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresentationsList(
    BuildContext context,
    WidgetRef ref,
    PresentationState state,
    PresentationNotifier notifier,
    bool isDark,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(InhaleSpacing.md),
            itemCount: state.presentations.length,
            itemBuilder: (context, index) {
              final pres = state.presentations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                child: GlassCard(
                  onTap: () => notifier.openPresentation(index),
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  elevated: true,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? InhaleColors.electricBlue.withValues(
                                    alpha: 0.2,
                                  )
                                  : InhaleColors.lightPrimaryBlue.withValues(
                                    alpha: 0.15,
                                  ),
                          borderRadius: BorderRadius.circular(InhaleRadius.md),
                        ),
                        child: Icon(
                          Icons.present_to_all_rounded,
                          color:
                              isDark
                                  ? InhaleColors.electricBlue
                                  : InhaleColors.lightPrimaryBlue,
                        ),
                      ),
                      const SizedBox(width: InhaleSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pres.title,
                              style: InhaleTypography.titleSmall.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textPrimary
                                        : InhaleColors.lightNavyText,
                              ),
                            ),
                            Text(
                              '${pres.slideCount} slides',
                              style: InhaleTypography.bodySmall.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textMuted
                                        : InhaleColors.lightTextMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color:
                            isDark
                                ? InhaleColors.textMuted
                                : InhaleColors.lightTextMuted,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: GlassButton(
            width: double.infinity,
            label: 'New Presentation',
            onTap: () => _showNewPresentationDialog(context, notifier, isDark),
            glow: true,
          ),
        ),
        const SizedBox(height: InhaleSpacing.md),
      ],
    );
  }

  void _showNewPresentationDialog(
    BuildContext context,
    PresentationNotifier notifier,
    bool isDark,
  ) {
    final topicController = TextEditingController();
    final slidesController = TextEditingController(text: '5');

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor:
                isDark ? InhaleColors.darkCharcoal : InhaleColors.lightSurface,
            title: Text(
              'New Presentation',
              style: TextStyle(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlassTextField(
                  controller: topicController,
                  hintText: 'Enter topic...',
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassTextField(
                  controller: slidesController,
                  hintText: 'Number of slides (default 5)',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: InhaleColors.blue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final topic = topicController.text.trim();
                  if (topic.isNotEmpty) {
                    final slides =
                        int.tryParse(slidesController.text.trim()) ?? 5;
                    notifier.generatePresentation(topic, slides: slides);
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: InhaleColors.blue,
                ),
                child: const Text('Generate'),
              ),
            ],
          ),
    );
  }
}
