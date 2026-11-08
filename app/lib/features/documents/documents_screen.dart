import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'documents_provider.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(documentsProvider);
    final notifier = ref.read(documentsProvider.notifier);
    return Scaffold(
      appBar: GlassAppBar(title: 'Documents'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: GlassTextField(hintText: 'Search documents...', onChanged: (v) => notifier.search(v)),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  GlassButton(label: 'Add', onTap: () => notifier.addDocument()),
                ],
              ),
            ),
            Expanded(
              child: state.documents.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.description_outlined, size: 64, color: InhaleColors.secondaryText),
                          const SizedBox(height: InhaleSpacing.md),
                          Text('No Documents Yet', style: InhaleTypography.titleMedium),
                          const SizedBox(height: InhaleSpacing.sm),
                          Text('Add a document to get started', style: InhaleTypography.bodyMedium.copyWith(color: InhaleColors.secondaryText)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                      itemCount: state.documents.length,
                      itemBuilder: (context, index) {
                        final doc = state.documents[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            onTap: () => notifier.openDocument(index),
                            padding: EdgeInsets.all(InhaleSpacing.md),
                            child: Row(
                              children: [
                                Icon(Icons.description_rounded, color: InhaleColors.primaryBlue, size: 24),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(doc['name'] ?? 'Document', style: InhaleTypography.titleSmall),
                                      Text(doc['type'] ?? 'PDF', style: InhaleTypography.bodySmall.copyWith(color: InhaleColors.secondaryText)),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right_rounded, color: InhaleColors.secondaryText),
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
