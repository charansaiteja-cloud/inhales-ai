import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'writing_provider.dart';

class WritingScreen extends ConsumerWidget {
  const WritingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(writingProvider);
    final notifier = ref.read(writingProvider.notifier);
    final modes = [WritingMode.essay, WritingMode.letter, WritingMode.email, WritingMode.report, WritingMode.story, WritingMode.poem];
    final modeLabels = {WritingMode.essay: 'Essay', WritingMode.letter: 'Letter', WritingMode.email: 'Email', WritingMode.report: 'Report', WritingMode.story: 'Story', WritingMode.poem: 'Poem'};
    return Scaffold(
      appBar: GlassAppBar(title: 'Writing Assistant'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(InhaleSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Writing Mode', style: InhaleTypography.headlineMedium),
            const SizedBox(height: InhaleSpacing.sm),
            Wrap(spacing: 8, runSpacing: 8, children: modes.map((m) {
              final selected = m == state.mode;
              return GlassCard(
                onTap: () => notifier.setMode(m),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(modeLabels[m]!, style: TextStyle(color: selected ? Colors.white : InhaleColors.primaryBlue, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
                backgroundColor: selected ? InhaleColors.primaryBlue : InhaleColors.glassSurface,
              );
            }).toList()),
            const SizedBox(height: InhaleSpacing.lg),
            Text('Instructions', style: InhaleTypography.titleMedium),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(maxLines: 3, hintText: 'Describe what you want to write...', onChanged: (v) => notifier.setInstructions(v)),
            const SizedBox(height: InhaleSpacing.lg),
            Text('Content', style: InhaleTypography.titleMedium),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(maxLines: 15, hintText: 'Your content will appear here...', onChanged: (v) => notifier.setContent(v)),
            const SizedBox(height: InhaleSpacing.lg),
            GlassButton(width: double.infinity, label: 'Generate Content', onTap: () => notifier.generateContent()),
          ],
        ),
      ),
    );
  }
}
