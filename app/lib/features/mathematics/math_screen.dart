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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Mathematics'),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Expression',
                style: InhaleTypography.headlineMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  hintText: 'e.g. 2 + 3 * 4 or (10 - 5) / 2',
                  onChanged: (v) => notifier.setInput(v),
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassButton(
                width: double.infinity,
                label: state.isComputing ? 'Calculating...' : 'Calculate',
                onTap: state.isComputing ? null : () => notifier.compute(),
                glow: !state.isComputing,
              ),
              if (state.output.isNotEmpty) ...[
                const SizedBox(height: InhaleSpacing.lg),
                Text(
                  'Result',
                  style: InhaleTypography.titleMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  elevated: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.output,
                        style: InhaleTypography.displaySmall.copyWith(
                          color:
                              isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText,
                        ),
                      ),
                      if (state.steps.isNotEmpty) ...[
                        const SizedBox(height: InhaleSpacing.sm),
                        Text(
                          state.steps,
                          style: InhaleTypography.bodySmall.copyWith(
                            color:
                                isDark
                                    ? InhaleColors.textSecondary
                                    : InhaleColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              // History
              if (state.history.isNotEmpty) ...[
                const SizedBox(height: InhaleSpacing.xl),
                Text(
                  'Calculation History',
                  style: InhaleTypography.titleMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.sm),
                  child: Column(
                    children:
                        state.history.take(10).map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: InhaleSpacing.xs,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        isDark
                                            ? InhaleColors.electricBlue
                                                .withValues(alpha: 0.15)
                                            : InhaleColors.lightPrimaryBlue
                                                .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(
                                      InhaleRadius.sm,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.calculate_rounded,
                                    size: 16,
                                    color:
                                        isDark
                                            ? InhaleColors.electricBlue
                                            : InhaleColors.lightPrimaryBlue,
                                  ),
                                ),
                                const SizedBox(width: InhaleSpacing.sm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.expression,
                                        style: InhaleTypography.bodySmall
                                            .copyWith(
                                              color:
                                                  isDark
                                                      ? InhaleColors
                                                          .textSecondary
                                                      : InhaleColors
                                                          .lightTextSecondary,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        entry.result,
                                        style: InhaleTypography.bodySmall
                                            .copyWith(
                                              color:
                                                  isDark
                                                      ? InhaleColors.textPrimary
                                                      : InhaleColors
                                                          .lightNavyText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
