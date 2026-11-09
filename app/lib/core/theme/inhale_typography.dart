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

  static const TextStyle lightBodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextPrimary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightBodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: InhaleColors.lightTextSecondary,
    fontFamily: _fontFamily,
  );

  static const TextStyle lightHeadlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: InhaleColors.lightNavyText,
    fontFamily: _fontFamily,
  );
}
