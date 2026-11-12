import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'video_learning_provider.dart';

class VideoLearningScreen extends ConsumerWidget {
  const VideoLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(videoLearningProvider);
    final notifier = ref.read(videoLearningProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Video Learning'),
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
                'AI Video Learning',
                style: InhaleTypography.headlineMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.xs),
              Text(
                'Upload a video to get transcripts, summaries, and Q&A',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              GlassTextField(
                hintText: 'https://example.com/video.mp4',
                onSubmitted: (url) {
                  if (url.trim().isNotEmpty) {
                    notifier.processVideo(url.trim());
                  }
                },
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassButton(
                label: 'Process Video',
                onTap: () {
                  final url = '';
                  if (url.isNotEmpty) {
                    notifier.processVideo(url.trim());
                  }
                },
                glow: true,
              ),
              if (state.isLoading) ...[
                const SizedBox(height: InhaleSpacing.lg),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(InhaleSpacing.md),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
              if (state.error != null) ...[
                const SizedBox(height: InhaleSpacing.sm),
                Text(
                  state.error!,
                  style: InhaleTypography.bodySmall.copyWith(
                    color: InhaleColors.error,
                  ),
                ),
              ],
              if (state.summary != null) ...[
                const SizedBox(height: InhaleSpacing.lg),
                Text(
                  'Summary',
                  style: InhaleTypography.headlineSmall.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.xs),
                GlassCard(
                  child: Text(
                    state.summary!,
                    style: InhaleTypography.bodyMedium.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                ),
                if (state.keyTopics.isNotEmpty) ...[
                  const SizedBox(height: InhaleSpacing.md),
                  Text(
                    'Key Topics',
                    style: InhaleTypography.headlineSmall.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                  const SizedBox(height: InhaleSpacing.xs),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.keyTopics.map((topic) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? InhaleColors.glassSurface
                              : InhaleColors.lightGlassSurface,
                          borderRadius: BorderRadius.circular(
                            InhaleRadius.pill,
                          ),
                          border: Border.all(
                            color: isDark
                                ? InhaleColors.glassBorderSubtle
                                : InhaleColors.lightGlassBorderSubtle,
                          ),
                        ),
                        child: Text(
                          topic,
                          style: InhaleTypography.labelMedium.copyWith(
                            color: isDark
                                ? InhaleColors.blue
                                : InhaleColors.lightPrimaryBlue,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
