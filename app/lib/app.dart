import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/inhale_theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'features/settings/settings_provider.dart';

class InhaleSkillApp extends ConsumerWidget {
  const InhaleSkillApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settingsState = ref.watch(settingsProvider);

    return settingsState.when(
      data:
          (settings) => MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme:
                settings.themeMode == ThemeMode.dark
                    ? InhaleTheme.darkTheme
                    : InhaleTheme.lightTheme,
            darkTheme: InhaleTheme.darkTheme,
            themeMode: settings.themeMode,
            routerConfig: router,
          ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (_, __) => MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: InhaleTheme.lightTheme,
            darkTheme: InhaleTheme.darkTheme,
            routerConfig: router,
          ),
    );
  }
}
