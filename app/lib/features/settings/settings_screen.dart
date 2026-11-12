import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_app_bar.dart';
import 'settings_provider.dart';
import '../../di/ui_settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Settings'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: settingsAsync.when(
          data: (settings) =>
              _buildSettingsBody(context, ref, settings, isDark),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              const Center(child: Text('Error loading settings')),
        ),
      ),
    );
  }

  Widget _buildSettingsBody(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    bool isDark,
  ) {
    final notifier = ref.read(settingsProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      children: [
        // Appearance Section
        _SectionHeader(title: 'Appearance', isDark: isDark),
        const SizedBox(height: InhaleSpacing.sm),
        _SettingsTile(
          context: context,
          icon: Icons.palette_rounded,
          title: 'Theme',
          subtitle: settings.themeMode == ThemeMode.dark ? 'Dark' : 'Light',
          isDark: isDark,
          trailing: Switch(
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (v) =>
                notifier.setTheme(v ? ThemeMode.dark : ThemeMode.light),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),
        _SettingsTile(
          context: context,
          icon: Icons.contrast,
          title: 'High‑contrast mode',
          subtitle: ref.watch(uiSettingsProvider).highContrast ? 'On' : 'Off',
          isDark: isDark,
          trailing: Switch(
            value: ref.watch(uiSettingsProvider).highContrast,
            onChanged: (v) =>
                ref.read(uiSettingsProvider.notifier).state = UiSettings(
              mode: ref.watch(uiSettingsProvider).mode,
              highContrast: v,
            ),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),
        _SettingsTile(
          context: context,
          icon: Icons.animation_rounded,
          title: 'Reduced Motion',
          subtitle: settings.reducedAnimation ? 'On' : 'Off',
          isDark: isDark,
          trailing: Switch(
            value: settings.reducedAnimation,
            onChanged: (v) => notifier.setReducedAnimation(v),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),
        _SettingsTile(
          context: context,
          icon: Icons.blur_off_rounded,
          title: 'Reduced Blur',
          subtitle: settings.reducedBlur ? 'On' : 'Off',
          isDark: isDark,
          trailing: Switch(
            value: settings.reducedBlur,
            onChanged: (v) => notifier.setReducedBlur(v),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),

        const SizedBox(height: InhaleSpacing.lg),

        // AI & Models Section
        _SectionHeader(title: 'AI & Models', isDark: isDark),
        const SizedBox(height: InhaleSpacing.sm),
        _SettingsTile(
          context: context,
          icon: Icons.download_rounded,
          title: 'Manage Models',
          subtitle: 'Download and configure AI models',
          isDark: isDark,
          onTap: () {},
        ),
        _SettingsTile(
          context: context,
          icon: Icons.tune_rounded,
          title: 'Context Length',
          subtitle: '${settings.contextLength} tokens',
          isDark: isDark,
        ),
        _SettingsTile(
          context: context,
          icon: Icons.memory_rounded,
          title: 'CPU Threads',
          subtitle: '${settings.cpuThreads} threads',
          isDark: isDark,
        ),
        _SettingsTile(
          context: context,
          icon: Icons.memory_rounded,
          title: 'GPU Acceleration',
          subtitle: settings.useGpu ? 'Enabled' : 'Disabled',
          isDark: isDark,
          trailing: Switch(
            value: settings.useGpu,
            onChanged: (v) => notifier.setUseGpu(v),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),

        const SizedBox(height: InhaleSpacing.lg),

        // Data & Privacy Section
        _SectionHeader(title: 'Data & Privacy', isDark: isDark),
        const SizedBox(height: InhaleSpacing.sm),
        _SettingsTile(
          context: context,
          icon: Icons.cloud_off_rounded,
          title: 'Offline Mode',
          subtitle: settings.offlineMode ? 'Active' : 'Inactive',
          isDark: isDark,
          trailing: Switch(
            value: settings.offlineMode,
            onChanged: (v) => notifier.setOffline(v),
            activeThumbColor: isDark
                ? InhaleColors.electricBlue
                : InhaleColors.lightPrimaryBlue,
          ),
        ),
        _SettingsTile(
          context: context,
          icon: Icons.delete_sweep_rounded,
          title: 'Clear Data',
          subtitle: 'Remove all local data and models',
          isDark: isDark,
          iconColor: InhaleColors.error,
          iconBgColor: isDark
              ? InhaleColors.error.withValues(alpha: 0.15)
              : InhaleColors.error.withValues(alpha: 0.1),
          onTap: () {},
        ),

        const SizedBox(height: InhaleSpacing.lg),

        // About Section
        _SectionHeader(title: 'About', isDark: isDark),
        const SizedBox(height: InhaleSpacing.sm),
        _SettingsTile(
          context: context,
          icon: Icons.info_outline_rounded,
          title: 'Version',
          subtitle: '1.0.0-alpha',
          isDark: isDark,
        ),
        _SettingsTile(
          context: context,
          icon: Icons.code_rounded,
          title: 'Built With',
          subtitle: 'Flutter + llama.cpp (offline AI)',
          isDark: isDark,
        ),

        const SizedBox(height: InhaleSpacing.xl),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionHeader({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: InhaleTypography.titleLarge.copyWith(
        color: isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? iconBgColor;

  const _SettingsTile({
    required this.context,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ??
        (isDark ? InhaleColors.electricBlue : InhaleColors.lightPrimaryBlue);
    final effectiveIconBgColor = iconBgColor ??
        (isDark
            ? InhaleColors.electricBlue.withValues(alpha: 0.15)
            : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.1));

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(InhaleSpacing.md),
        elevated: onTap != null,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: effectiveIconBgColor,
                borderRadius: BorderRadius.circular(InhaleRadius.md),
              ),
              child: Icon(icon, color: effectiveIconColor, size: 20),
            ),
            const SizedBox(width: InhaleSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: InhaleTypography.titleSmall.copyWith(
                      color: isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: InhaleTypography.bodySmall.copyWith(
                      color: isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.chevron_right_rounded,
                color: isDark
                    ? InhaleColors.textMuted
                    : InhaleColors.lightTextMuted,
              ),
          ],
        ),
      ),
    );
  }
}
