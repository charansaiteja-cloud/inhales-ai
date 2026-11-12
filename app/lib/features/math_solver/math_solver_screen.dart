import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';

import '../../widgets/glass_app_bar.dart';
import 'math_solver_provider.dart';

class MathSolverScreen extends ConsumerWidget {
  const MathSolverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mathSolverProvider);
    final notifier = ref.read(mathSolverProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Math Solver AI'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image upload section
              Text(
                'Upload Image of Problem',
                style: InhaleTypography.headlineMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: Column(
                  children: [
                    if (state.image != null)
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              InhaleRadius.sm,
                            ),
                            child: Image.file(
                              state.image!,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: InhaleSpacing.sm),
                          GlassButton(
                            width: double.infinity,
                            label: state.isProcessing
                                ? 'Analyzing...'
                                : 'Analyze Image',
                            onTap: state.isProcessing
                                ? null
                                : () => notifier.analyzeImage(),
                            glow: !state.isProcessing,
                          ),
                        ],
                      )
                    else
                      GlassButton(
                        width: double.infinity,
                        label: 'Pick Image',
                        onTap: () => notifier.pickImage(),
                        glow: true,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              // Recognized expression
              if (state.recognizedExpression != null) ...[
                Text(
                  'Recognized Expression',
                  style: InhaleTypography.headlineMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  child: Text(
                    state.recognizedExpression!,
                    style: InhaleTypography.displaySmall.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                ),
                const SizedBox(height: InhaleSpacing.md),
                // Solve button
                GlassButton(
                  width: double.infinity,
                  label: state.isProcessing ? 'Solving...' : 'Solve',
                  onTap: state.isProcessing ? null : () => notifier.solve(),
                  glow: !state.isProcessing,
                ),
                const SizedBox(height: InhaleSpacing.md),
              ],
              // Solution and steps
              if (state.answer != null) ...[
                Text(
                  'Answer',
                  style: InhaleTypography.headlineMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  child: Text(
                    state.answer!,
                    style: InhaleTypography.displaySmall.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                ),
                const SizedBox(height: InhaleSpacing.md),
                if (state.steps.isNotEmpty) ...[
                  Text(
                    'Step‑by‑Step Solution',
                    style: InhaleTypography.headlineMedium.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                  const SizedBox(height: InhaleSpacing.sm),
                  GlassCard(
                    padding: const EdgeInsets.all(InhaleSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.steps
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: InhaleSpacing.xs,
                              ),
                              child: Text(
                                '${e.key + 1}. ${e.value}',
                                style: InhaleTypography.bodySmall.copyWith(
                                  color: isDark
                                      ? InhaleColors.textSecondary
                                      : InhaleColors.lightTextSecondary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: InhaleSpacing.md),
                ],
              ],
              // History
              if (state.history.isNotEmpty) ...[
                Text(
                  'History',
                  style: InhaleTypography.titleMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.sm),
                  child: Column(
                    children: state.history.take(10).map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: InhaleSpacing.xs,
                        ),
                        child: Row(
                          children: [
                            if (entry.originalImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  InhaleRadius.sm,
                                ),
                                child: Image.file(
                                  entry.originalImage!,
                                  height: 36,
                                  width: 36,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Icon(
                                Icons.calculate_rounded,
                                size: 24,
                                color: isDark
                                    ? InhaleColors.electricBlue
                                    : InhaleColors.lightPrimaryBlue,
                              ),
                            const SizedBox(width: InhaleSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.expression,
                                    style: InhaleTypography.bodySmall.copyWith(
                                      color: isDark
                                          ? InhaleColors.textSecondary
                                          : InhaleColors.lightTextSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    entry.answer,
                                    style: InhaleTypography.bodySmall.copyWith(
                                      color: isDark
                                          ? InhaleColors.textPrimary
                                          : InhaleColors.lightNavyText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: 20,
                                color: isDark
                                    ? InhaleColors.electricBlue
                                    : InhaleColors.lightPrimaryBlue,
                              ),
                              tooltip: 'Load',
                              onPressed: () => notifier.loadFromHistory(entry),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 20,
                                color: isDark
                                    ? InhaleColors.error
                                    : InhaleColors.pink,
                              ),
                              tooltip: 'Delete',
                              onPressed: () async {
                                final idx = state.history.indexOf(entry);
                                await notifier.removeFromHistory(idx);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: InhaleSpacing.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
