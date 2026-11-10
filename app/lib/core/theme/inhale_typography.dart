/// InhaleSkill AI — Typography scale.
/// Premium, readable typography for a learning/productivity app.
library;

import 'package:flutter/material.dart';
import 'inhale_colors.dart';

class InhaleTypography {
  InhaleTypography._();

  static const String _fontFamily = 'SF Pro Display';

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: InhaleColors.textPrimary,
    letterSpacing: -0.5,
    fontFamily: _fontFamily,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.15,
    color: InhaleColors.textPrimary,
    letterSpacing: -0.3,
    fontFamily: _fontFamily,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  // Headline
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textMuted,
    fontFamily: _fontFamily,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.textSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.textSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.textMuted,
    fontFamily: _fontFamily,
  );

  // Light theme variants
  static const TextStyle lightDisplayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: InhaleColors.lightNavyText,
    letterSpacing: -0.5,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightDisplayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.15,
    color: InhaleColors.lightNavyText,
    letterSpacing: -0.3,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightDisplaySmall = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightHeadlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightHeadlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightHeadlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightTitleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightTitleMedium = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightTitleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightBodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightBodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextMuted,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightLabelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.lightTextSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightLabelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.lightTextSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightLabelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: InhaleColors.lightTextMuted,
    fontFamily: _fontFamily,
  );

  // Dark theme variants
  static const TextStyle darkDisplayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: InhaleColors.textPrimary,
    letterSpacing: -0.5,
    fontFamily: _fontFamily,
  );

  static const TextStyle darkHeadlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle darkBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle darkBodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle darkBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.textPrimary,
    fontFamily: _fontFamily,
  );

  // Additional aliases for backward compatibility
  static const TextStyle h2 = headlineLarge;
  static const TextStyle h3 = headlineSmall;
  static const TextStyle caption = bodySmall;
  static const TextStyle pageTitle = headlineLarge;
  static const TextStyle buttonSmall = labelLarge;
  static const TextStyle buttonMedium = labelLarge;
  static const TextStyle buttonLarge = titleMedium;
}

// Alias for backward compatibility
class AppTypography {
  AppTypography._();
  static const TextStyle displayLarge = InhaleTypography.displayLarge;
  static const TextStyle displayMedium = InhaleTypography.displayMedium;
  static const TextStyle displaySmall = InhaleTypography.displaySmall;
  static const TextStyle headlineLarge = InhaleTypography.headlineLarge;
  static const TextStyle headlineMedium = InhaleTypography.headlineMedium;
  static const TextStyle headlineSmall = InhaleTypography.headlineSmall;
  static const TextStyle titleLarge = InhaleTypography.titleLarge;
  static const TextStyle titleMedium = InhaleTypography.titleMedium;
  static const TextStyle titleSmall = InhaleTypography.titleSmall;
  static const TextStyle bodyLarge = InhaleTypography.bodyLarge;
  static const TextStyle bodyMedium = InhaleTypography.bodyMedium;
  static const TextStyle bodySmall = InhaleTypography.bodySmall;
  static const TextStyle body = InhaleTypography.body;
  static const TextStyle labelLarge = InhaleTypography.labelLarge;
  static const TextStyle labelMedium = InhaleTypography.labelMedium;
  static const TextStyle labelSmall = InhaleTypography.labelSmall;
  static const TextStyle lightDisplayLarge = InhaleTypography.lightDisplayLarge;
  static const TextStyle lightBodyLarge = InhaleTypography.lightBodyLarge;
  static const TextStyle lightBodySmall = InhaleTypography.lightBodySmall;
  static const TextStyle lightHeadlineLarge =
      InhaleTypography.lightHeadlineLarge;
  static const TextStyle lightHeadlineMedium =
      InhaleTypography.lightHeadlineMedium;
  static const TextStyle lightHeadlineSmall =
      InhaleTypography.lightHeadlineSmall;
  static const TextStyle lightTitleLarge = InhaleTypography.lightTitleLarge;
  static const TextStyle lightTitleMedium = InhaleTypography.lightTitleMedium;
  static const TextStyle lightTitleSmall = InhaleTypography.lightTitleSmall;
  static const TextStyle lightLabelLarge = InhaleTypography.lightLabelLarge;
  static const TextStyle lightLabelMedium = InhaleTypography.lightLabelMedium;
  static const TextStyle lightLabelSmall = InhaleTypography.lightLabelSmall;
  static const TextStyle lightDisplayMedium =
      InhaleTypography.lightDisplayMedium;
  static const TextStyle lightDisplaySmall = InhaleTypography.lightDisplaySmall;
  static const TextStyle lightBodyMedium = InhaleTypography.lightBodyMedium;
  static const TextStyle lightBody = InhaleTypography.lightBody;
  static const TextStyle darkDisplayLarge = InhaleTypography.darkDisplayLarge;
  static const TextStyle darkHeadlineLarge = InhaleTypography.darkHeadlineLarge;
  static const TextStyle darkBodyLarge = InhaleTypography.darkBodyLarge;
  static const TextStyle darkBodyMedium = InhaleTypography.darkBodyMedium;
  static const TextStyle darkBody = InhaleTypography.darkBody;
  static const TextStyle h2 = InhaleTypography.h2;
  static const TextStyle h3 = InhaleTypography.h3;
  static const TextStyle caption = InhaleTypography.caption;
  static const TextStyle pageTitle = InhaleTypography.pageTitle;
  static const TextStyle buttonSmall = InhaleTypography.buttonSmall;
  static const TextStyle buttonMedium = InhaleTypography.buttonMedium;
  static const TextStyle buttonLarge = InhaleTypography.buttonLarge;
}
