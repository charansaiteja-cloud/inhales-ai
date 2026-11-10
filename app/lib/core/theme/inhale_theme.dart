import 'package:flutter/material.dart';
import 'inhale_colors.dart';
import 'inhale_typography.dart';
import 'inhale_tokens.dart';

/// Centralised theme system for InhaleSkill AI.
class InhaleTheme {
  InhaleTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: InhaleColors.lightPrimaryBlue,
      secondary: InhaleColors.lightSkyBlue,
    ),
    scaffoldBackgroundColor: InhaleColors.lightBackground,
    canvasColor: InhaleColors.lightSurface,
    textTheme: const TextTheme(
      displayLarge: InhaleTypography.lightDisplayLarge,
      headlineLarge: InhaleTypography.lightHeadlineLarge,
      bodyLarge: InhaleTypography.lightBodyLarge,
      bodyMedium: InhaleTypography.lightBodyMedium,
    ),
    iconTheme: const IconThemeData(color: InhaleColors.lightNavyText),
    cardTheme: CardThemeData(
      color: InhaleColors.lightGlassSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleSpacing.md),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: InhaleColors.primaryBlue,
      secondary: InhaleColors.skyBlue,
    ),
    scaffoldBackgroundColor: InhaleColors.darkBackground,
    canvasColor: InhaleColors.darkSurface,
    textTheme: const TextTheme(
      displayLarge: InhaleTypography.darkDisplayLarge,
      headlineLarge: InhaleTypography.darkHeadlineLarge,
      bodyLarge: InhaleTypography.darkBodyLarge,
      bodyMedium: InhaleTypography.darkBodyMedium,
    ),
    iconTheme: const IconThemeData(color: InhaleColors.pureWhite),
    cardTheme: CardThemeData(
      color: InhaleColors.darkGlassSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InhaleSpacing.md),
      ),
    ),
  );
}
