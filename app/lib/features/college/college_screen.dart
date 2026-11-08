import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import 'college_provider.dart';

class CollegeScreen extends ConsumerWidget {
  const CollegeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collegeProvider);
    return Scaffold(
      appBar: GlassAppBar(title: 'College Learning'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: CustomScrollView(slivers: [
          SliverPadding(padding: EdgeInsets.all(InhaleSpacing.md), sliver: SliverToBoxAdapter(child: Text('Choose Your Subject', style: InhaleTypography.headlineLarge))),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final subject = state.subjects[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GlassCard(
                    onTap: () => ref.read(collegeProvider.notifier).selectSubject(subject),
                    padding: EdgeInsets.all(InhaleSpacing.md),
                    child: Row(children: [
                      Expanded(child: Text(subject, style: InhaleTypography.titleMedium)),
                      if (state.selectedSubject == subject) Icon(Icons.check_circle_rounded, color: InhaleColors.primaryBlue),
                    ]),
                  ),
                );
              }, childCount: state.subjects.length),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(InhaleSpacing.md),
            sliver: SliverToBoxAdapter(
              child: GlassButton(
                width: double.infinity,
                label: state.selectedSubject != null ? 'Start Learning: ${state.selectedSubject!}' : 'Select a Subject',
                onTap: state.selectedSubject != null ? () => GoRouter.of(context).push('/chat?mode=college') : null,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
