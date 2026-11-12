import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import 'vision_provider.dart';

class VisionScreen extends ConsumerWidget {
  const VisionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(visionProvider);
    final notifier = ref.read(visionProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Vision AI',
        actions: [
          GlassIconButton(
            onTap: () => _pickImage(notifier),
            icon: Icons.add_photo_alternate_rounded,
            color: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ],
      ),
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
                'Image Analysis',
                style: InhaleTypography.headlineMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.xs),
              Text(
                'Upload an image and ask AI to analyze it',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassCard(
                padding: EdgeInsets.zero,
                elevated: true,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(InhaleRadius.lg),
                  ),
                  child: state.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            InhaleRadius.lg,
                          ),
                          child: Image.file(
                            state.image!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_rounded,
                                size: 56,
                                color: isDark
                                    ? InhaleColors.electricBlue
                                        .withValues(alpha: 0.5)
                                    : InhaleColors.lightPrimaryBlue
                                        .withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: InhaleSpacing.sm),
                              Text(
                                'Tap to upload or paste an image',
                                style: InhaleTypography.bodyMedium.copyWith(
                                  color: isDark
                                      ? InhaleColors.textSecondary
                                      : InhaleColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              Text(
                'Describe What You Need',
                style: InhaleTypography.titleMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassTextField(
                hintText: 'e.g. What is in this image? Solve this problem...',
                maxLines: 3,
                minLines: 2,
                onChanged: (v) => notifier.setPrompt(v),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              GlassButton(
                width: double.infinity,
                label: state.isProcessing ? 'Analyzing...' : 'Analyze Image',
                onTap: state.isProcessing || state.image == null
                    ? null
                    : () => notifier.analyzeImage(),
                glow: !state.isProcessing && state.image != null,
              ),
              if (state.result != null && state.result!.isNotEmpty) ...[
                const SizedBox(height: InhaleSpacing.lg),
                Text(
                  'Analysis Result',
                  style: InhaleTypography.titleMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  elevated: true,
                  child: Text(
                    state.result!,
                    style: InhaleTypography.bodyLarge.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(VisionNotifier notifier) async {
    await notifier.pickImage();
  }
}
