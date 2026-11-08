import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import '../../ai/models/model_catalog.dart';
import '../../ai/manager/model_manager_provider.dart';

class ModelManagerScreen extends ConsumerWidget {
  const ModelManagerScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelState = ref.watch(modelManagerProvider);
    final catalog = ModelCatalog.getModels();
    return Scaffold(
      appBar: GlassAppBar(title: 'Models'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: GlassCard(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: Row(
                  children: [
                    Icon(
                      Icons.storage_rounded,
                      color: InhaleColors.primaryBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Installed Models',
                            style: InhaleTypography.titleSmall,
                          ),
                          Text(
                            '${modelState.installedModels.length} installed',
                            style: InhaleTypography.bodySmall.copyWith(
                              color: InhaleColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(InhaleSpacing.md),
                itemCount: catalog.length,
                itemBuilder: (context, index) {
                  final model = catalog[index];
                  final installed = modelState.installedModels.any(
                    (m) => m.id == model.id,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GlassCard(
                      padding: EdgeInsets.all(InhaleSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model.name,
                                      style: InhaleTypography.titleSmall,
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: InhaleColors.primaryBlue
                                            .withAlpha(40),
                                        borderRadius: BorderRadius.circular(
                                          InhaleRadius.sm,
                                        ),
                                      ),
                                      child: Text(
                                        model.ramTier,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: InhaleColors.primaryBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${model.sizeLabel}  ·  ${model.provider}',
                                  style: InhaleTypography.bodySmall.copyWith(
                                    color: InhaleColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GlassButton(
                            label: installed ? 'Installed' : 'Download',
                            onTap:
                                installed
                                    ? null
                                    : () => ref
                                        .read(modelManagerProvider.notifier)
                                        .installModel(model),
                            disabled: installed,
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
