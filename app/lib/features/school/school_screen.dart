import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import 'school_provider.dart';

class SchoolScreen extends ConsumerWidget {
  const SchoolScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schoolProvider);
    return Scaffold(
      appBar: GlassAppBar(title: 'School Learning'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: CustomScrollView(slivers: [
          SliverPadding(
            padding: EdgeInsets.all(InhaleSpacing.md),
            sliver: SliverToBoxAdapter(child: Text('Select Your Class', style: InhaleTypography.headlineLarge)),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisExtent: 64, crossAxisSpacing: 8, mainAxisSpacing: 8),
              delegate: SliverChildBuilderDelegate((context, index) {
                final cls = index + 1;
                final selected = cls == state.selectedClass;
                return GlassCard(
                  onTap: () => ref.read(schoolProvider.notifier).selectClass(cls),
                  child: Center(child: Text('Class $cls', style: TextStyle(color: selected ? Colors.white : InhaleColors.primaryBlue, fontWeight: selected ? FontWeight.w700 : FontWeight.w500))),
                  backgroundColor: selected ? InhaleColors.primaryBlue : InhaleColors.glassSurface,
                );
              }, childCount: 10),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(InhaleSpacing.md),
            sliver: SliverToBoxAdapter(child: Text('Select Subject', style: InhaleTypography.headlineLarge)),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final subject = state.subjects[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GlassCard(
                    onTap: () => ref.read(schoolProvider.notifier).selectSubject(subject.name),
                    padding: EdgeInsets.all(InhaleSpacing.md),
                    child: Row(children: [
                      Text(subject.icon, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(subject.name, style: InhaleTypography.titleMedium)),
                      Icon(Icons.chevron_right_rounded, color: InhaleColors.secondaryText),
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
                label: state.selectedSubject != null ? 'Start Learning: ${state.selectedSubject!}' : 'Select a Subject First',
                onTap: state.selectedSubject != null ? () => GoRouter.of(context).push('/chat?mode=school') : null,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
