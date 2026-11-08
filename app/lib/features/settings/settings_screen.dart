import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_app_bar.dart';
import 'settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    return Scaffold(
      appBar: GlassAppBar(title: 'Settings'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: settingsAsync.when(
          data: (settings) => _buildSettingsBody(context, ref, settings),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('Error loading settings')),
        ),
      ),
    );
  }

  Widget _buildSettingsBody(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    final notifier = ref.read(settingsProvider.notifier);
    final isDark = settings.themeMode == ThemeMode.dark;
    return ListView(
      padding: EdgeInsets.all(InhaleSpacing.md),
      children: [
        Text('Appearance', style: InhaleTypography.headlineSmall),
        const SizedBox(height: InhaleSpacing.sm),
        _settingsTile(
          context,
          icon: Icons.palette_rounded,
          title: 'Theme',
          subtitle: isDark ? 'Dark' : 'Light',
          trailing: Switch(
            value: isDark,
            onChanged:
                (v) => notifier.setTheme(v ? ThemeMode.dark : ThemeMode.light),
            activeColor: InhaleColors.primaryBlue,
          ),
        ),
        _settingsTile(
          context,
          icon: Icons.animation_rounded,
          title: 'Reduced Motion',
          subtitle: settings.reducedAnimation ? 'On' : 'Off',
          trailing: Switch(
            value: settings.reducedAnimation,
            onChanged: (v) => notifier.setReducedAnimation(v),
            activeColor: InhaleColors.primaryBlue,
          ),
        ),
        _settingsTile(
          context,
          icon: Icons.blur_off_rounded,
          title: 'Reduced Blur',
          subtitle: settings.reducedBlur ? 'On' : 'Off',
          trailing: Switch(
            value: settings.reducedBlur,
            onChanged: (v) => notifier.setReducedBlur(v),
            activeColor: InhaleColors.primaryBlue,
          ),
        ),
        const SizedBox(height: InhaleSpacing.lg),
        Text('AI & Models', style: InhaleTypography.headlineSmall),
        const SizedBox(height: InhaleSpacing.sm),
        _settingsTile(
          context,
          icon: Icons.download_rounded,
          title: 'Manage Models',
          subtitle: 'Download and configure AI models',
          onTap: () {},
        ),
        _settingsTile(
          context,
          icon: Icons.tune_rounded,
          title: 'Context Length',
          subtitle: '${settings.contextLength} tokens',
          onTap: null,
        ),
        _settingsTile(
          context,
          icon: Icons.memory_rounded,
          title: 'CPU Threads',
          subtitle: '${settings.cpuThreads} threads',
          onTap: null,
        ),
        const SizedBox(height: InhaleSpacing.lg),
        Text('Data & Privacy', style: InhaleTypography.headlineSmall),
        const SizedBox(height: InhaleSpacing.sm),
        _settingsTile(
          context,
          icon: Icons.cloud_off_rounded,
          title: 'Offline Mode',
          subtitle: settings.offlineMode ? 'Active' : 'Inactive',
          trailing: Switch(
            value: settings.offlineMode,
            onChanged: (v) => notifier.setOffline(v),
            activeColor: InhaleColors.primaryBlue,
          ),
        ),
        _settingsTile(
          context,
          icon: Icons.delete_sweep_rounded,
          title: 'Clear Data',
          subtitle: 'Remove all local data and models',
          onTap: () {},
        ),
        const SizedBox(height: InhaleSpacing.lg),
        Text('About', style: InhaleTypography.headlineSmall),
        const SizedBox(height: InhaleSpacing.sm),
        _settingsTile(
          context,
          icon: Icons.info_outline_rounded,
          title: 'Version',
          subtitle: '1.0.0-alpha',
          onTap: null,
        ),
        _settingsTile(
          context,
          icon: Icons.code_rounded,
          title: 'Built With',
          subtitle: 'Flutter + llama.cpp (offline AI)',
          onTap: null,
        ),
      ],
    );
  }

  Widget _settingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GlassCard(
        onTap: onTap,
        padding: EdgeInsets.all(InhaleSpacing.md),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: InhaleColors.lightGlassBlue.withAlpha(100),
                borderRadius: BorderRadius.circular(InhaleRadius.md),
              ),
              child: Icon(icon, color: InhaleColors.primaryBlue, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: InhaleTypography.titleSmall),
                  Text(
                    subtitle,
                    style: InhaleTypography.bodySmall.copyWith(
                      color: InhaleColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (onTap != null)
              Icon(
                Icons.chevron_right_rounded,
                color: InhaleColors.secondaryText,
              ),
          ],
        ),
      ),
    );
  }
}
