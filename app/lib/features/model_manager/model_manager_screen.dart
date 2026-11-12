import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../ai/models/model_catalog.dart';
import '../../ai/manager/model_manager_provider.dart';

class ModelManagerScreen extends ConsumerWidget {
  const ModelManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelState = ref.watch(modelManagerProvider);
    final catalog = ModelCatalog.getModels();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hardware = modelState.hardware;
    final ramGB = (hardware.totalRamMb / 1024).toStringAsFixed(1);
    final freeStorageGB = (hardware.storageFreeMb / 1024).toStringAsFixed(1);
    final canRunModels = hardware.canRunBalanced;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Model Manager',
        actions: [
          GlassIconButton(
            onTap: () => ref.read(modelManagerProvider.notifier).refresh(),
            icon: Icons.refresh_rounded,
            color: isDark
                ? InhaleColors.textSecondary
                : InhaleColors.lightTextSecondary,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: Column(
          children: [
            // Hardware Info Card
            Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.lg),
                elevated: true,
                glow: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: InhaleColors.gradientPrimary,
                            borderRadius: BorderRadius.circular(
                              InhaleRadius.sm,
                            ),
                          ),
                          child: const Icon(
                            Icons.memory_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: InhaleSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Device Capability',
                                style: InhaleTypography.titleMedium.copyWith(
                                  color: isDark
                                      ? InhaleColors.textPrimary
                                      : InhaleColors.lightNavyText,
                                ),
                              ),
                              Text(
                                '${ramGB}GB RAM • ${canRunModels ? 'Ready' : 'Limited'}',
                                style: InhaleTypography.bodySmall.copyWith(
                                  color: isDark
                                      ? InhaleColors.textSecondary
                                      : InhaleColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: canRunModels
                                ? InhaleColors.successSoft
                                : InhaleColors.warningSoft,
                            borderRadius: BorderRadius.circular(
                              InhaleRadius.pill,
                            ),
                          ),
                          child: Text(
                            canRunModels ? 'Optimal' : 'Low RAM',
                            style: InhaleTypography.labelSmall.copyWith(
                              color: canRunModels
                                  ? InhaleColors.success
                                  : InhaleColors.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: InhaleSpacing.md),
                    Row(
                      children: [
                        _InfoChip(
                          label: 'CPU',
                          value: '${hardware.cpuCores} cores',
                          isDark: isDark,
                        ),
                        const SizedBox(width: InhaleSpacing.sm),
                        _InfoChip(
                          label: 'GPU',
                          value: hardware.gpuAvailable ? 'Available' : 'None',
                          isDark: isDark,
                        ),
                        const SizedBox(width: InhaleSpacing.sm),
                        _InfoChip(
                          label: 'Storage',
                          value: '${freeStorageGB}GB free',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search & Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
              child: GlassTextField(
                hintText: 'Search models...',
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: isDark
                      ? InhaleColors.textMuted
                      : InhaleColors.lightTextMuted,
                ),
                onChanged: (value) {
                  // TODO: implement search filter
                },
              ),
            ),

            const SizedBox(height: InhaleSpacing.md),

            // Installed Models Section
            if (modelState.installedModels.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: InhaleSpacing.md,
                ),
                child: Row(
                  children: [
                    Text(
                      'Installed',
                      style: InhaleTypography.titleMedium.copyWith(
                        color: isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                      ),
                    ),
                    const SizedBox(width: InhaleSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? InhaleColors.electricBlue.withValues(
                                alpha: 0.2,
                              )
                            : InhaleColors.lightPrimaryBlue.withValues(
                                alpha: 0.15,
                              ),
                        borderRadius: BorderRadius.circular(InhaleRadius.pill),
                      ),
                      child: Text(
                        '${modelState.installedModels.length}',
                        style: InhaleTypography.labelSmall.copyWith(
                          color: isDark
                              ? InhaleColors.electricBlue
                              : InhaleColors.lightPrimaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InhaleSpacing.md,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: modelState.installedModels.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: InhaleSpacing.md),
                  itemBuilder: (context, index) {
                    final model = modelState.installedModels[index];
                    final isLoaded = modelState.activeModel?.id == model.id;

                    return _InstalledModelCard(
                      model: model,
                      isLoaded: isLoaded,
                      onLoad: () => ref
                          .read(modelManagerProvider.notifier)
                          .setActiveModel(model),
                      onUnload: () => ref
                          .read(modelManagerProvider.notifier)
                          .setActiveModel(
                            modelState.installedModels.firstWhere(
                              (m) => m.id != model.id,
                              orElse: () => model,
                            ),
                          ),
                      onDelete: () => ref
                          .read(modelManagerProvider.notifier)
                          .deleteModel(model.id),
                    );
                  },
                ),
              ),
            ],

            // Available Models Section
            const SizedBox(height: InhaleSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
              child: Row(
                children: [
                  Text(
                    'Available Models',
                    style: InhaleTypography.titleMedium.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                itemCount: catalog.length,
                itemBuilder: (context, index) {
                  final model = catalog[index];
                  final installed = modelState.installedModels.any(
                    (m) => m.id == model.id,
                  );
                  final isLoaded = modelState.activeModel?.id == model.id;
                  final downloading = modelState.downloads[model.id];
                  final isDownloading =
                      downloading != null && !downloading.isComplete;
                  final downloadProgress = downloading?.progress ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                    child: _AvailableModelCard(
                      model: model,
                      installed: installed,
                      isLoaded: isLoaded,
                      isDownloading: isDownloading,
                      downloadProgress: downloadProgress,
                      onDownload: () => ref
                          .read(modelManagerProvider.notifier)
                          .installModel(model),
                      onLoad: () => ref
                          .read(modelManagerProvider.notifier)
                          .setActiveModel(model),
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

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _InfoChip({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? InhaleColors.glassSurface
              : InhaleColors.lightGlassSurface,
          borderRadius: BorderRadius.circular(InhaleRadius.sm),
          border: Border.all(
            color: isDark
                ? InhaleColors.glassBorderSubtle
                : InhaleColors.lightGlassBorderSubtle,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: InhaleTypography.labelSmall.copyWith(
                color: isDark
                    ? InhaleColors.textMuted
                    : InhaleColors.lightTextMuted,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: InhaleTypography.bodySmall.copyWith(
                color: isDark
                    ? InhaleColors.textPrimary
                    : InhaleColors.lightNavyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InstalledModelCard extends StatelessWidget {
  final dynamic model;
  final bool isLoaded;
  final VoidCallback onLoad;
  final VoidCallback onUnload;
  final VoidCallback onDelete;

  const _InstalledModelCard({
    required this.model,
    required this.isLoaded,
    required this.onLoad,
    required this.onUnload,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 200,
      child: GlassCard(
        padding: const EdgeInsets.all(InhaleSpacing.md),
        elevated: isLoaded,
        glow: isLoaded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: isLoaded
                        ? InhaleColors.gradientPrimary
                        : InhaleColors.gradientAccent,
                    borderRadius: BorderRadius.circular(InhaleRadius.xs),
                  ),
                  child: Icon(
                    Icons.model_training_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: InhaleSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: InhaleTypography.titleSmall.copyWith(
                          color: isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model.sizeLabel} • ${model.provider}',
                        style: InhaleTypography.labelSmall.copyWith(
                          color: isDark
                              ? InhaleColors.textMuted
                              : InhaleColors.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? InhaleColors.electricBlue.withValues(alpha: 0.2)
                        : InhaleColors.lightPrimaryBlue.withValues(
                            alpha: 0.15,
                          ),
                    borderRadius: BorderRadius.circular(InhaleRadius.xs),
                  ),
                  child: Text(
                    model.ramTier,
                    style: InhaleTypography.labelSmall.copyWith(
                      color: isDark
                          ? InhaleColors.electricBlue
                          : InhaleColors.lightPrimaryBlue,
                      fontSize: 9,
                    ),
                  ),
                ),
                const Spacer(),
                if (isLoaded)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: InhaleColors.successSoft,
                      borderRadius: BorderRadius.circular(InhaleRadius.xs),
                    ),
                    child: Text(
                      'LOADED',
                      style: InhaleTypography.labelSmall.copyWith(
                        color: InhaleColors.success,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Row(
              children: [
                if (isLoaded) ...[
                  Expanded(
                    child: GlassButton(
                      label: 'Unload',
                      onTap: onUnload,
                      outlined: true,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.xs),
                  Expanded(
                    child: GlassButton(
                      label: 'Delete',
                      onTap: onDelete,
                      outlined: true,
                      height: 32,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: GlassButton(
                      label: 'Load',
                      onTap: onLoad,
                      height: 32,
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.xs),
                  Expanded(
                    child: GlassButton(
                      label: 'Delete',
                      onTap: onDelete,
                      outlined: true,
                      height: 32,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailableModelCard extends StatelessWidget {
  final dynamic model;
  final bool installed;
  final bool isLoaded;
  final bool isDownloading;
  final double downloadProgress;
  final VoidCallback onDownload;
  final VoidCallback onLoad;

  const _AvailableModelCard({
    required this.model,
    required this.installed,
    required this.isLoaded,
    required this.isDownloading,
    required this.downloadProgress,
    required this.onDownload,
    required this.onLoad,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: isLoaded,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  isDownloading
                      ? InhaleColors.electricBlue
                      : (installed
                          ? InhaleColors.violet
                          : InhaleColors.electricBlue),
                  isDownloading
                      ? InhaleColors.softCyan
                      : (installed
                          ? InhaleColors.violetSoft
                          : InhaleColors.violet),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(InhaleRadius.sm),
            ),
            child: Icon(
              isDownloading
                  ? Icons.download_rounded
                  : Icons.model_training_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: InhaleSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        model.name,
                        style: InhaleTypography.titleSmall.copyWith(
                          color: isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? InhaleColors.electricBlue.withValues(
                                alpha: 0.2,
                              )
                            : InhaleColors.lightPrimaryBlue.withValues(
                                alpha: 0.15,
                              ),
                        borderRadius: BorderRadius.circular(InhaleRadius.xs),
                      ),
                      child: Text(
                        model.ramTier,
                        style: InhaleTypography.labelSmall.copyWith(
                          color: isDark
                              ? InhaleColors.electricBlue
                              : InhaleColors.lightPrimaryBlue,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${model.sizeLabel}  ·  ${model.provider}',
                  style: InhaleTypography.bodySmall.copyWith(
                    color: isDark
                        ? InhaleColors.textSecondary
                        : InhaleColors.lightTextSecondary,
                  ),
                ),
                if (isDownloading) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(InhaleRadius.xs),
                    child: LinearProgressIndicator(
                      value: downloadProgress,
                      minHeight: 4,
                      backgroundColor: isDark
                          ? InhaleColors.glassSurface
                          : InhaleColors.lightGlassSurface,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDark
                            ? InhaleColors.electricBlue
                            : InhaleColors.lightPrimaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Downloading... ${(downloadProgress * 100).toInt()}%',
                    style: InhaleTypography.labelSmall.copyWith(
                      color: isDark
                          ? InhaleColors.textMuted
                          : InhaleColors.lightTextMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isLoaded)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: InhaleColors.successSoft,
                borderRadius: BorderRadius.circular(InhaleRadius.pill),
              ),
              child: Text(
                'Loaded',
                style: InhaleTypography.labelSmall.copyWith(
                  color: InhaleColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (installed && !isDownloading)
            GlassButton(
              label: 'Load',
              onTap: onLoad,
              iconOnly: true,
              width: 80,
              height: 36,
            )
          else if (!installed && !isDownloading)
            GlassButton(
              label: 'Download',
              onTap: onDownload,
              iconOnly: true,
              width: 100,
              height: 36,
            ),
        ],
      ),
    );
  }
}
