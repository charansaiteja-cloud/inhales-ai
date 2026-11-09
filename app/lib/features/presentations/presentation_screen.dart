import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import 'presentation_provider.dart';

class PresentationScreen extends ConsumerWidget {
  const PresentationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(presentationProvider);
    final notifier = ref.read(presentationProvider.notifier);
    return Scaffold(
      appBar: GlassAppBar(title: 'Presentations'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child:
            state.presentations.isEmpty
                ? _buildEmptyState(context, notifier)
                : _buildPresentationsList(context, ref, state, notifier),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, dynamic notifier) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.slideshow_rounded,
            size: 64,
            color: InhaleColors.secondaryText,
          ),
          const SizedBox(height: InhaleSpacing.md),
          Text('No Presentations Yet', style: InhaleTypography.titleMedium),
          const SizedBox(height: InhaleSpacing.sm),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.xl),
            child: Text(
              'Create a presentation from a topic or generate one with AI',
              style: InhaleTypography.bodyMedium.copyWith(
                color: InhaleColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: InhaleSpacing.lg),
          SizedBox(
            width: 240,
            child: GlassButton(
              label: 'Create from Topic',
              onTap: () => notifier.showTopicInput(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresentationsList(
    BuildContext context,
    WidgetRef ref,
    dynamic state,
    dynamic notifier,
  ) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(InhaleSpacing.md),
            itemCount: state.presentations.length,
            itemBuilder: (context, index) {
              final pres = state.presentations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GlassCard(
                  onTap: () => notifier.openPresentation(index),
                  padding: EdgeInsets.all(InhaleSpacing.md),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: InhaleColors.lightGlassBlue.withAlpha(200),
                          borderRadius: BorderRadius.circular(InhaleRadius.md),
                        ),
                        child: Icon(
                          Icons.present_to_all_rounded,
                          color: InhaleColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pres['title'] ?? 'Untitled',
                              style: InhaleTypography.titleSmall,
                            ),
                            Text(
                              '${pres['slides'] ?? 0} slides',
                              style: InhaleTypography.bodySmall.copyWith(
                                color: InhaleColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: InhaleColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: GlassButton(
            width: double.infinity,
            label: 'New Presentation',
            onTap: () => notifier.showTopicInput(),
          ),
        ),
        const SizedBox(height: InhaleSpacing.md),
      ],
    );
  }
}
