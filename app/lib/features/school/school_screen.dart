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
import 'school_provider.dart';

class SchoolScreen extends ConsumerWidget {
  const SchoolScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schoolProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'School Learning',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: InhaleSpacing.md),
            child: GlassButton(
              label:
                  state.selectedClass > 0
                      ? 'Class ${state.selectedClass}'
                      : 'Select Class',
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
                      'Select Your Class',
                      style: InhaleTypography.headlineMedium.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textPrimary
                                : InhaleColors.lightNavyText,
                      ),
                    ),
                    const SizedBox(height: InhaleSpacing.xs),
                    Text(
                      'Choose your grade level to personalize content',
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
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisExtent: 64,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final cls = index + 1;
                  final selected = cls == state.selectedClass;
                  return GlassCard(
                    onTap:
                        () =>
                            ref.read(schoolProvider.notifier).selectClass(cls),
                    padding: const EdgeInsets.all(InhaleSpacing.sm),
                    elevated: selected,
                    glow: selected,
                    child: Center(
                      child: Text(
                        'Class $cls',
                        style: TextStyle(
                          color:
                              selected
                                  ? Colors.white
                                  : (isDark
                                      ? InhaleColors.electricBlue
                                      : InhaleColors.lightPrimaryBlue),
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }, childCount: 10),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Subject',
                      style: InhaleTypography.headlineMedium.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textPrimary
                                : InhaleColors.lightNavyText,
                      ),
                    ),
                    const SizedBox(height: InhaleSpacing.xs),
                    Text(
                      'Pick a subject to start learning',
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                    child: GlassCard(
                      onTap:
                          () => ref
                              .read(schoolProvider.notifier)
                              .selectSubject(subject.name),
                      padding: const EdgeInsets.all(InhaleSpacing.md),
                      elevated: state.selectedSubject == subject.name,
                      glow: state.selectedSubject == subject.name,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient:
                                  state.selectedSubject == subject.name
                                      ? InhaleColors.gradientPrimary
                                      : InhaleColors.gradientAccent,
                              borderRadius: BorderRadius.circular(
                                InhaleRadius.sm,
                              ),
                            ),
                            child: Text(
                              subject.icon,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(width: InhaleSpacing.md),
                          Expanded(
                            child: Text(
                              subject.name,
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
                                    .read(schoolProvider.notifier)
                                    .selectSubject(subject.name),
                            icon:
                                state.selectedSubject == subject.name
                                    ? Icons.check_circle_rounded
                                    : Icons.chevron_right_rounded,
                            color:
                                state.selectedSubject == subject.name
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
                          : 'Select a Subject First',
                  onTap:
                      state.selectedSubject != null
                          ? () => GoRouter.of(context).push('/chat?mode=school')
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
