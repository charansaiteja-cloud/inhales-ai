import 'package:flutter/material.dart';
import 'inhale_colors.dart';
import 'inhale_typography.dart';
import 'inhale_tokens.dart';

/// Centralised theme system for InhaleSkill AI.
/// Never construct a theme inline — always use InhaleTheme.of(context).
class InhaleTheme {
  InhaleTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: InhaleColors.primaryBlue,
      onPrimary: InhaleColors.pureWhite,
      secondary: InhaleColors.skyBlue,
      onSecondary: InhaleColors.navyText,
      surface: InhaleColors.pureWhite,
      onSurface: InhaleColors.navyText,
      surfaceContainerHighest: InhaleColors.iceWhite,
      error: InhaleColors.error,
      outline: InhaleColors.lightGlassBlue,
    ),
    scaffoldBackgroundColor: InhaleColors.backgroundBlue,
    canvasColor: InhaleColors.pureWhite,
    cardTheme: CardThemeData(
      color: InhaleColors.glassSurface,
      elevation: 0,
      shape: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(InhaleRadius.md)),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateColor.resolveWith(
        (_) => InhaleColors.primaryBlue.withValues(alpha: 0.4),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: InhaleColors.lightGlassBlue,
      thickness: 0.5,
    ),
    textTheme: TextTheme(
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
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.ios: ZoomPageTransitionsBuilder(),
        TargetPlatform.linux: ZoomPageTransitionsBuilder(),
        TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.windows: ZoomPageTransitionsBuilder(),
      },
    ),
    snackbarTheme: SnackbarThemeData(
      behavior: SnackbarBehavior.floating,
      shape: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(InhaleRadius.md)),
      ),
      backgroundColor: InhaleColors.navyText,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    dialogTheme: DialogThemeData(
      shape: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(InhaleRadius.lg)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: InhaleColors.skyBlue,
      onPrimary: InhaleColors.darkBackground,
      secondary: InhaleColors.primaryBlue,
      onSecondary: InhaleColors.darkNavyText,
      surface: InhaleColors.darkSurface,
      onSurface: InhaleColors.darkNavyText,
      surfaceContainerHighest: InhaleColors.darkBackground,
      error: InhaleColors.error,
      outline: InhaleColors.darkGlassBorder,
    ),
    scaffoldBackgroundColor: InhaleColors.darkBackground,
    canvasColor: InhaleColors.darkSurface,
    textTheme: TextTheme(
      displayLarge: InhaleTypography.darkDisplayLarge,
      headlineLarge: InhaleTypography.darkHeadlineLarge,
      bodyLarge: InhaleTypography.darkBodyLarge,
      bodySmall: InhaleTypography.darkBodySmall,
    ),
    snackbarTheme: SnackbarThemeData(
      behavior: SnackbarBehavior.floating,
      backgroundColor: InhaleColors.darkSurface,
      contentTextStyle: const TextStyle(color: InhaleColors.darkNavyText),
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
      isDark ? InhaleColors.darkBackground : InhaleColors.backgroundBlue;

  Color get surface =>
      isDark ? InhaleColors.darkGlassSurface : InhaleColors.glassSurface;

  Color get text =>
      isDark ? InhaleColors.darkNavyText : InhaleColors.navyText;

  Color get secondaryText =>
      isDark ? InhaleColors.darkSecondaryText : InhaleColors.secondaryText;

  Color get primary =>
      isDark ? InhaleColors.skyBlue : InhaleColors.primaryBlue;

  double get blur => isDark ? InhaleBlur.medium : InhaleBlur.light;
}