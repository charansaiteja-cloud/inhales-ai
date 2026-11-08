import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'math_provider.dart';

class MathScreen extends ConsumerWidget {
  const MathScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mathProvider);
    final notifier = ref.read(mathProvider.notifier);
    return Scaffold(
      appBar: GlassAppBar(title: 'Mathematics'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(InhaleSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter Expression', style: InhaleTypography.headlineMedium),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(
              hintText: 'e.g. 2 + 3 * 4 or (10 - 5) / 2',
              onChanged: (v) => notifier.setInput(v),
            ),
            const SizedBox(height: InhaleSpacing.md),
            GlassButton(
              width: double.infinity,
              label: 'Calculate',
              onTap: () => notifier.compute(),
            ),
            if (state.output.isNotEmpty) ...[
              const SizedBox(height: InhaleSpacing.lg),
              Text('Result', style: InhaleTypography.titleMedium),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.output, style: InhaleTypography.displaySmall),
                    if (state.steps.isNotEmpty) ...[
                      const SizedBox(height: InhaleSpacing.sm),
                      Text(state.steps, style: InhaleTypography.bodySmall),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
