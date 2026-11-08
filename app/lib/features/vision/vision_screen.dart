import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'vision_provider.dart';

class VisionScreen extends ConsumerWidget {
  const VisionScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(visionProvider);
    final notifier = ref.read(visionProvider.notifier);
    return Scaffold(
      appBar: GlassAppBar(title: 'Vision AI'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Image Analysis', style: InhaleTypography.headlineMedium),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: InhaleColors.glassBorder),
                    borderRadius: BorderRadius.circular(InhaleRadius.lg),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_rounded,
                          size: 48,
                          color: InhaleColors.secondaryText,
                        ),
                        const SizedBox(height: InhaleSpacing.sm),
                        Text(
                          'Tap to upload or paste an image',
                          style: InhaleTypography.bodyMedium.copyWith(
                            color: InhaleColors.secondaryText,
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
                style: InhaleTypography.titleMedium,
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassTextField(
                hintText: 'e.g. What is in this image? Solve this problem...',
                onChanged: (v) => notifier.setPrompt(v),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              GlassButton(
                width: double.infinity,
                label: state.isProcessing ? 'Analyzing...' : 'Analyze Image',
                onTap:
                    state.isProcessing ? null : () => notifier.analyzeImage(),
              ),
              if (state.result != null && state.result!.isNotEmpty) ...[
                const SizedBox(height: InhaleSpacing.lg),
                Text('Analysis Result', style: InhaleTypography.titleMedium),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: EdgeInsets.all(InhaleSpacing.md),
                  child: Text(state.result!, style: InhaleTypography.bodyLarge),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
