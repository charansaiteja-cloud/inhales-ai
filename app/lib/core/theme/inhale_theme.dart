import 'package:flutter/material.dart';
import 'inhale_colors.dart';
import 'inhale_typography.dart';
import 'inhale_tokens.dart';

/// Smooth page transition for premium feel.
class _SmoothPageTransitionBuilder extends PageTransitionsBuilder {
  const _SmoothPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: child,
    );
  }
}

/// Centralised theme system for InhaleSkill AI.
/// Dark theme is the primary visual identity.
class InhaleTheme {
  InhaleTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: InhaleColors.lightPrimaryBlue,
      onPrimary: InhaleColors.pureWhite,
      secondary: InhaleColors.lightSkyBlue,
      onSecondary: InhaleColors.lightNavyText,
      surface: InhaleColors.lightSurface,
      onSurface: InhaleColors.lightNavyText,
      surfaceContainerHighest: InhaleColors.lightIceWhite,
      error: InhaleColors.error,
      outline: InhaleColors.lightLightGlassBlue,
    ),
    scaffoldBackgroundColor: InhaleColors.lightBackground,
    canvasColor: InhaleColors.lightSurface,
    cardTheme: CardThemeData(
      color: InhaleColors.lightGlassSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.md),
        side: const BorderSide(
          color: InhaleColors.lightGlassBorderSubtle,
          width: 0.5,
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateColor.resolveWith(
        (_) => InhaleColors.lightPrimaryBlue.withValues(alpha: 0.4),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: InhaleColors.lightLightGlassBlue,
      thickness: 0.5,
    ),
    textTheme: const TextTheme(
      displayLarge: InhaleTypography.lightDisplayLarge,
      headlineLarge: InhaleTypography.lightHeadlineLarge,
      bodyLarge: InhaleTypography.lightBodyLarge,
      bodySmall: InhaleTypography.lightBodySmall,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        for (final platform in TargetPlatform.values)
          platform: const _SmoothPageTransitionBuilder(),
      },
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.md),
      ),
      backgroundColor: InhaleColors.lightNavyText,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.lg),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: InhaleColors.electricBlue,
      onPrimary: InhaleColors.midnight,
      secondary: InhaleColors.softCyan,
      onSecondary: InhaleColors.midnight,
      surface: InhaleColors.darkNavy,
      onSurface: InhaleColors.textPrimary,
      surfaceContainerHighest: InhaleColors.deepNavy,
      error: InhaleColors.error,
      outline: InhaleColors.glassBorderSubtle,
    ),
    scaffoldBackgroundColor: InhaleColors.midnight,
    canvasColor: InhaleColors.darkNavy,
    cardTheme: CardThemeData(
      color: InhaleColors.glassSurfaceMedium,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.md),
        side: const BorderSide(
          color: InhaleColors.glassBorderSubtle,
          width: 0.5,
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateColor.resolveWith(
        (_) => InhaleColors.electricBlue.withValues(alpha: 0.4),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: InhaleColors.glassBorderSubtle,
      thickness: 0.5,
    ),
    textTheme: const TextTheme(
      displayLarge: InhaleTypography.displayLarge,
      displayMedium: InhaleTypography.displayMedium,
      displaySmall: InhaleTypography.displaySmall,
      headlineLarge: InhaleTypography.headlineLarge,
      headlineMedium: InhaleTypography.headlineMedium,
      headlineSmall: InhaleTypography.headlineSmall,
      titleLarge: InhaleTypography.titleLarge,
      titleMedium: InhaleTypography.titleMedium,
      titleSmall: InhaleTypography.titleSmall,
      bodyLarge: InhaleTypography.bodyLarge,
      bodyMedium: InhaleTypography.bodyMedium,
      bodySmall: InhaleTypography.bodySmall,
      labelLarge: InhaleTypography.labelLarge,
      labelMedium: InhaleTypography.labelMedium,
      labelSmall: InhaleTypography.labelSmall,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        for (final platform in TargetPlatform.values)
          platform: const _SmoothPageTransitionBuilder(),
      },
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.md),
      ),
      backgroundColor: InhaleColors.deepNavy,
      contentTextStyle: const TextStyle(color: InhaleColors.textPrimary),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.lg),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: InhaleColors.glassSurfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.sm),
        borderSide: const BorderSide(color: InhaleColors.glassBorderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.sm),
        borderSide: const BorderSide(color: InhaleColors.glassBorderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InhaleRadius.sm),
        borderSide: const BorderSide(
          color: InhaleColors.electricBlue,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );

  static InhaleThemeData of(BuildContext context) {
    return InhaleThemeData._(context);
  }
}

/// Convenience accessor holding resolved theme values.
class InhaleThemeData {
  final BuildContext _context;

  InhaleThemeData._(this._context);

  bool get isDark => Theme.of(_context).brightness == Brightness.dark;

  Color get background =>
      isDark ? InhaleColors.midnight : InhaleColors.lightBackground;

  Color get surface =>
      isDark ? InhaleColors.glassSurfaceMedium : InhaleColors.lightGlassSurface;

  Color get text =>
      isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;

  Color get secondaryText =>
      isDark ? InhaleColors.textSecondary : InhaleColors.lightTextSecondary;

  Color get primary =>
      isDark ? InhaleColors.electricBlue : InhaleColors.lightPrimaryBlue;

  double get blur => isDark ? InhaleBlur.medium : InhaleBlur.light;
}
