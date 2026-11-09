import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import 'college_provider.dart';

class CollegeScreen extends ConsumerWidget {
  const CollegeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collegeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'College Learning',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: InhaleSpacing.md),
            child: GlassButton(
              label:
                  state.selectedSubject != null
                      ? state.selectedSubject!
                      : 'Select Subject',
              onTap: null,
              outlined: true,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Subject',
                      style: InhaleTypography.headlineMedium.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textPrimary
                                : InhaleColors.lightNavyText,
                      ),
                    ),
                    const SizedBox(height: InhaleSpacing.xs),
                    Text(
                      'Select a subject area to begin your studies',
                      style: InhaleTypography.bodyMedium.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textSecondary
                                : InhaleColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final subject = state.subjects[index];
                  final selected = state.selectedSubject == subject;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                    child: GlassCard(
                      onTap:
                          () => ref
                              .read(collegeProvider.notifier)
                              .selectSubject(subject),
                      padding: const EdgeInsets.all(InhaleSpacing.md),
                      elevated: selected,
                      glow: selected,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient:
                                  selected
                                      ? InhaleColors.gradientPrimary
                                      : InhaleColors.gradientAccent,
                              borderRadius: BorderRadius.circular(
                                InhaleRadius.sm,
                              ),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: InhaleSpacing.md),
                          Expanded(
                            child: Text(
                              subject,
                              style: InhaleTypography.titleMedium.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textPrimary
                                        : InhaleColors.lightNavyText,
                              ),
                            ),
                          ),
                          GlassIconButton(
                            onTap:
                                () => ref
                                    .read(collegeProvider.notifier)
                                    .selectSubject(subject),
                            icon:
                                selected
                                    ? Icons.check_circle_rounded
                                    : Icons.chevron_right_rounded,
                            color:
                                selected
                                    ? InhaleColors.success
                                    : (isDark
                                        ? InhaleColors.textMuted
                                        : InhaleColors.lightTextMuted),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: state.subjects.length),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              sliver: SliverToBoxAdapter(
                child: GlassButton(
                  width: double.infinity,
                  label:
                      state.selectedSubject != null
                          ? 'Start Learning: ${state.selectedSubject!}'
                          : 'Select a Subject',
                  onTap:
                      state.selectedSubject != null
                          ? () =>
                              GoRouter.of(context).push('/chat?mode=college')
                          : null,
                  glow: state.selectedSubject != null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
