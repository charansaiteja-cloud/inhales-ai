import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import 'documents_provider.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentsProvider);
    final notifier = ref.read(documentsProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Documents',
        actions: [
          GlassIconButton(
            onTap: () => notifier.addDocument(),
            icon: Icons.add_rounded,
            color:
                isDark
                    ? InhaleColors.electricBlue
                    : InhaleColors.lightPrimaryBlue,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: GlassTextField(
                hintText: 'Search documents...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color:
                      isDark
                          ? InhaleColors.textMuted
                          : InhaleColors.lightTextMuted,
                ),
                onChanged: (v) => notifier.search(v),
              ),
            ),
            Expanded(
              child:
                  state.documents.isEmpty
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(InhaleSpacing.xl),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: InhaleColors.gradientPrimary,
                                  borderRadius: BorderRadius.circular(
                                    InhaleRadius.md,
                                  ),
                                ),
                                child: Icon(
                                  Icons.description_outlined,
                                  size: 48,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: InhaleSpacing.lg),
                              Text(
                                'No Documents Yet',
                                style: InhaleTypography.headlineSmall.copyWith(
                                  color:
                                      isDark
                                          ? InhaleColors.textPrimary
                                          : InhaleColors.lightNavyText,
                                ),
                              ),
                              const SizedBox(height: InhaleSpacing.sm),
                              Text(
                                'Add a PDF or text document to start chatting with your files.',
                                style: InhaleTypography.bodyMedium.copyWith(
                                  color:
                                      isDark
                                          ? InhaleColors.textSecondary
                                          : InhaleColors.lightTextSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: InhaleSpacing.lg),
                              GlassButton(
                                label: 'Add Document',
                                onTap: () => notifier.addDocument(),
                                width: 200,
                              ),
                            ],
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(InhaleSpacing.md),
                        itemCount: state.documents.length,
                        itemBuilder: (context, index) {
                          final doc = state.documents[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: InhaleSpacing.sm,
                            ),
                            child: GlassCard(
                              onTap: () => notifier.openDocument(index),
                              padding: const EdgeInsets.all(InhaleSpacing.md),
                              elevated: true,
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: InhaleColors.gradientPrimary,
                                      borderRadius: BorderRadius.circular(
                                        InhaleRadius.sm,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.description_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: InhaleSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['name'] ?? 'Document',
                                          style: InhaleTypography.titleSmall
                                              .copyWith(
                                                color:
                                                    isDark
                                                        ? InhaleColors
                                                            .textPrimary
                                                        : InhaleColors
                                                            .lightNavyText,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    isDark
                                                        ? InhaleColors
                                                            .electricBlue
                                                            .withValues(
                                                              alpha: 0.2,
                                                            )
                                                        : InhaleColors
                                                            .lightPrimaryBlue
                                                            .withValues(
                                                              alpha: 0.15,
                                                            ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      InhaleRadius.xs,
                                                    ),
                                              ),
                                              child: Text(
                                                doc['type'] ?? 'PDF',
                                                style: InhaleTypography
                                                    .labelSmall
                                                    .copyWith(
                                                      color:
                                                          isDark
                                                              ? InhaleColors
                                                                  .electricBlue
                                                              : InhaleColors
                                                                  .lightPrimaryBlue,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: InhaleSpacing.sm,
                                            ),
                                            Text(
                                              '${doc['size'] ?? 'Unknown'}',
                                              style: InhaleTypography.bodySmall
                                                  .copyWith(
                                                    color:
                                                        isDark
                                                            ? InhaleColors
                                                                .textMuted
                                                            : InhaleColors
                                                                .lightTextMuted,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  GlassIconButton(
                                    onTap: () => notifier.openDocument(index),
                                    icon: Icons.chevron_right_rounded,
                                    color:
                                        isDark
                                            ? InhaleColors.textMuted
                                            : InhaleColors.lightTextMuted,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
