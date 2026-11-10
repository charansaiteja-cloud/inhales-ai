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
import '../../widgets/glass_loading_indicator.dart';
import 'documents_provider.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData _getIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'md':
        return Icons.article_rounded;
      case 'txt':
        return Icons.note_rounded;
      default:
        return Icons.description_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentsProvider);
    final notifier = ref.read(documentsProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Load documents on first build
    ref.listen<DocumentsState>(documentsProvider, (prev, next) {
      if (prev == null && !next.isLoading) {
        notifier.loadDocuments();
      }
    });

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Documents',
        actions: [
          GlassIconButton(
            onTap: () => notifier.importDocument(),
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
                  state.isLoading
                      ? const Center(child: GlassLoadingIndicator())
                      : state.documents.isEmpty
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
                                'Add a PDF, Markdown, or text document to start chatting with your files.',
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
                                onTap: () => notifier.importDocument(),
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
                              onTap: () {
                                // Show document details
                                _showDocDetails(context, doc, notifier);
                              },
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
                                    child: Icon(
                                      _getIcon(doc.fileType),
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
                                          doc.title,
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
                                                doc.fileType.toUpperCase(),
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
                                              _formatSize(doc.sizeBytes),
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
                                    onTap: () {
                                      notifier.deleteDocument(doc.id);
                                    },
                                    icon: Icons.delete_outline_rounded,
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

  void _showDocDetails(
    BuildContext context,
    DocumentItem doc,
    DocumentsNotifier notifier,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor:
                isDark ? InhaleColors.darkCharcoal : InhaleColors.lightSurface,
            title: Text(
              doc.title,
              style: TextStyle(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type: ${doc.fileType.toUpperCase()}',
                  style: TextStyle(
                    color:
                        isDark
                            ? InhaleColors.textSecondary
                            : InhaleColors.lightTextSecondary,
                  ),
                ),
                Text(
                  'Size: ${_formatSize(doc.sizeBytes)}',
                  style: TextStyle(
                    color:
                        isDark
                            ? InhaleColors.textSecondary
                            : InhaleColors.lightTextSecondary,
                  ),
                ),
                Text(
                  'Imported: ${doc.importedAt.toString().split('.').first}',
                  style: TextStyle(
                    color:
                        isDark
                            ? InhaleColors.textSecondary
                            : InhaleColors.lightTextSecondary,
                  ),
                ),
                if (doc.summary != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Summary:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(doc.summary!),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Close',
                  style: TextStyle(color: InhaleColors.blue),
                ),
              ),
            ],
          ),
    );
  }
}
