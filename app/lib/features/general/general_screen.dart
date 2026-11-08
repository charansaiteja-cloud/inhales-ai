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
    final categoryIcons = {
      'General Knowledge': Icons.lightbulb_rounded, 'History': Icons.history_edu_rounded,
      'Geography': Icons.public_rounded, 'Science': Icons.science_rounded,
      'Technology': Icons.computer_rounded, 'Space': Icons.satellite_alt_rounded,
      'Astronomy': Icons.nights_stay_rounded, 'Environment': Icons.eco_rounded,
      'Languages': Icons.language_rounded, 'Career Guidance': Icons.work_outline_rounded,
      'Interview Preparation': Icons.person_search_rounded, 'Productivity': Icons.trending_up_rounded,
      'Skill Development': Icons.auto_stories_rounded, 'Problem Solving': Icons.puzzle_rounded,
    };
    return Scaffold(
      appBar: GlassAppBar(title: 'General Learning'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: GridView.builder(
          padding: EdgeInsets.all(InhaleSpacing.md),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 120, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];
            final icon = categoryIcons[category] ?? Icons.library_books_rounded;
            final selected = state.selectedCategory == category;
            return GlassCard(
              onTap: () { ref.read(generalProvider.notifier).selectCategory(category); GoRouter.of(context).push('/chat?mode=general'); },
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(color: (selected ? InhaleColors.primaryBlue : InhaleColors.lightGlassBlue).withAlpha(200), shape: BoxShape.circle),
                    child: Icon(icon, color: selected ? Colors.white : InhaleColors.primaryBlue, size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(category, style: InhaleTypography.titleSmall, textAlign: TextAlign.center),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
