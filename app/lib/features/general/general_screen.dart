import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_app_bar.dart';
import 'general_provider.dart';

class GeneralScreen extends ConsumerWidget {
  const GeneralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generalProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categoryIcons = {
      'General Knowledge': Icons.lightbulb_rounded,
      'History': Icons.history_edu_rounded,
      'Geography': Icons.public_rounded,
      'Science': Icons.science_rounded,
      'Technology': Icons.computer_rounded,
      'Space': Icons.satellite_alt_rounded,
      'Astronomy': Icons.nights_stay_rounded,
      'Environment': Icons.eco_rounded,
      'Languages': Icons.language_rounded,
      'Career Guidance': Icons.work_outline_rounded,
      'Interview Preparation': Icons.person_search_rounded,
      'Productivity': Icons.trending_up_rounded,
      'Skill Development': Icons.auto_stories_rounded,
      'Problem Solving': Icons.psychology_rounded,
    };

    return Scaffold(
      appBar: GlassAppBar(title: 'General Learning'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore Topics',
                style: InhaleTypography.headlineMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.xs),
              Text(
                'Select a category to start learning with AI',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 130,
                    crossAxisSpacing: InhaleSpacing.md,
                    mainAxisSpacing: InhaleSpacing.md,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    final icon =
                        categoryIcons[category] ?? Icons.library_books_rounded;
                    final selected = state.selectedCategory == category;
                    return GlassCard(
                      onTap: () {
                        ref
                            .read(generalProvider.notifier)
                            .selectCategory(category);
                        GoRouter.of(context).push('/chat?mode=general');
                      },
                      padding: const EdgeInsets.all(InhaleSpacing.md),
                      elevated: selected,
                      glow: selected,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: isDark
                                  ? (selected
                                      ? InhaleColors.electricBlue
                                      : InhaleColors.electricBlue
                                          .withValues(alpha: 0.15))
                                  : (selected
                                      ? InhaleColors.lightPrimaryBlue
                                      : InhaleColors.lightPrimaryBlue
                                          .withValues(alpha: 0.1)),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              icon,
                              color: selected
                                  ? Colors.white
                                  : (isDark
                                      ? InhaleColors.electricBlue
                                      : InhaleColors.lightPrimaryBlue),
                              size: 26,
                            ),
                          ),
                          const SizedBox(height: InhaleSpacing.sm),
                          Text(
                            category,
                            style: InhaleTypography.titleSmall.copyWith(
                              color: isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText,
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
