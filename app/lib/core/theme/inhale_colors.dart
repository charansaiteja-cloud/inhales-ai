/// InhaleSkill AI — Classic Glassmorphism Colour Palette.
/// Centralised colour definitions. Never hardcode colours elsewhere.
///
/// Dark theme is the primary visual identity.
/// Black theme: #050505, #171717, #262626 (primary dark surfaces)
/// Accent palette: Blue #1677D2, Sky Blue #38BDF8, Pink #EC4899
/// Light accents: Ice Blue #BAE6FD, Frost White #F8FAFC, Deep Navy #0B1F3A
library;

import 'package:flutter/material.dart';

class InhaleColors {
  InhaleColors._();

  // ── Core Identity (Black Theme Primary) ──────────────────
  static const black = Color(0xFF050505);
  static const darkCharcoal = Color(0xFF171717);
  static const glassGrey = Color(0xFF262626);
  static const deepNavy = Color(0xFF0B1F3A);

  // ── Accent Palette ──────────────────────────────────────
  static const blue = Color(0xFF1677D2);
  static const skyBlue = Color(0xFF38BDF8);
  static const pink = Color(0xFFEC4899);
  static const iceBlue = Color(0xFFBAE6FD);
  static const frostWhite = Color(0xFFF8FAFC);

  // ── Semantic ────────────────────────────────────────────
  static const success = Color(0xFF2ECC71);
  static const successSoft = Color(0x1A2ECC71);
  static const warning = Color(0xFFF1C40F);
  static const warningSoft = Color(0x1AF1C40F);
  static const error = Color(0xFFE74C3C);
  static const errorSoft = Color(0x1AE74C3C);
  static const info = Color(0xFF3498DB);

  // ── Text (Dark/Black Theme) ─────────────────────────────
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFFBAE6FD);
  static const textMuted = Color(0xFF7DD3FC);
  static const textOnGlass = Color(0xE6F8FAFC);
  static const textOnGlassSecondary = Color(0x99BAE6FD);

  // ── Glass Surfaces (Black Theme) ────────────────────────
  static const glassSurface = Color(0x1A262626);
  static const glassSurfaceMedium = Color(0x29262626);
  static const glassSurfaceHeavy = Color(0x40262626);
  static const glassSurfaceLight = Color(0x0F262626);
  static const glassSurfaceWhite = Color(0x0DFFFFFF);
  static const glassBorder = Color(0x33FFFFFF);
  static const glassBorderSubtle = Color(0x1AFFFFFF);
  static const glassBorderHighlight = Color(0x4DFFFFFF);
  static const glassShadow = Color(0x1A050505);
  static const glassShadowBlue = Color(0x141677D2);

  // ── Ambient Lighting ────────────────────────────────────
  static const ambientBlue = Color(0x141677D2);
  static const ambientPink = Color(0x0DEC4899);
  static const ambientSkyBlue = Color(0x0A38BDF8);

  // ── Light Theme ─────────────────────────────────────────
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightGlassSurface = Color(0x99FFFFFF);
  static const lightGlassSurfaceMedium = Color(0xCCFFFFFF);
  static const lightGlassBorder = Color(0x4DFFFFFF);
  static const lightGlassBorderSubtle = Color(0x26FFFFFF);
  static const lightTextPrimary = Color(0xFF0B1F3A);
  static const lightTextSecondary = Color(0xFF1677D2);
  static const lightTextMuted = Color(0xFF38BDF8);
  static const lightNavyText = Color(0xFF0B1F3A);
  static const lightSecondaryText = Color(0xFF1677D2);
  static const lightPrimaryBlue = Color(0xFF1677D2);
  static const lightDeepBlue = Color(0xFF0B1F3A);
  static const lightIceWhite = Color(0xFFF8FAFC);
  static const lightBackgroundBlue = Color(0xFFE0F2FE);
  static const lightLightGlassBlue = Color(0xFFBAE6FD);
  static const lightSkyBlue = Color(0xFF38BDF8);
  static const lightShadow = Color(0x0F0B1F3A);

  // ── Legacy Aliases (Backward Compat) ────────────────────
  static const pureWhite = frostWhite;
  static const primaryBlue = blue;
  static const deepBlue = deepNavy;
  static const navyText = lightNavyText;
  static const secondaryText = lightTextSecondary;
  static const iceWhite = lightIceWhite;
  static const backgroundBlue = lightBackgroundBlue;
  static const lightGlassBlue = lightLightGlassBlue;
  static const legacySkyBlue = lightSkyBlue;
  static const darkBackground = black;
  static const darkSurface = darkCharcoal;
  static const darkGlassSurface = glassSurfaceMedium;
  static const darkGlassBorder = glassBorderSubtle;
  static const darkNavyText = textPrimary;
  static const darkSecondaryText = textSecondary;
  static const darkPrimaryBlue = blue;

  // ── Gradients ───────────────────────────────────────────
  static const gradientPrimary = LinearGradient(
    colors: [blue, pink],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientAccent = LinearGradient(
    colors: [skyBlue, blue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientPink = LinearGradient(
    colors: [pink, blue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackgroundDark = LinearGradient(
    colors: [black, darkCharcoal, glassGrey],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradientBackgroundLight = LinearGradient(
    colors: [lightBackground, lightIceWhite, lightSurface],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackground = gradientBackgroundLight;

  static const gradientGlassOld = LinearGradient(
    colors: [Color(0xCCFFFFFF), Color(0x99BAE6FD)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientGlass = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x0D1677D2)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackgroundOld = gradientBackgroundLight;

  static const primaryGradient = LinearGradient(
    colors: [blue, pink],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const primaryGradientDark = LinearGradient(
    colors: [blue, pink],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Deprecated aliases ────────
  static const midnight = black;
  static const darkNavy = darkCharcoal;
  static const electricBlue = blue;
  static const softCyan = skyBlue;
  static const violet = pink;
  static const violetSoft = pink;
  static const glassWhite = frostWhite;
  static const ambientViolet = ambientPink;
  static const ambientCyan = ambientSkyBlue;
}

// Alias for backward compatibility - copy all constants
class AppColors {
  AppColors._();

  // Core Identity
  static const black = InhaleColors.black;
  static const darkCharcoal = InhaleColors.darkCharcoal;
  static const glassGrey = InhaleColors.glassGrey;
  static const deepNavy = InhaleColors.deepNavy;

  // Accent Palette
  static const blue = InhaleColors.blue;
  static const skyBlue = InhaleColors.skyBlue;
  static const pink = InhaleColors.pink;
  static const iceBlue = InhaleColors.iceBlue;
  static const frostWhite = InhaleColors.frostWhite;

  // Semantic
  static const success = InhaleColors.success;
  static const successSoft = InhaleColors.successSoft;
  static const warning = InhaleColors.warning;
  static const warningSoft = InhaleColors.warningSoft;
  static const error = InhaleColors.error;
  static const errorSoft = InhaleColors.errorSoft;
  static const info = InhaleColors.info;

  // Text (Dark/Black Theme)
  static const textPrimary = InhaleColors.textPrimary;
  static const textSecondary = InhaleColors.textSecondary;
  static const textMuted = InhaleColors.textMuted;
  static const textOnGlass = InhaleColors.textOnGlass;
  static const textOnGlassSecondary = InhaleColors.textOnGlassSecondary;

  // Glass Surfaces (Black Theme)
  static const glassSurface = InhaleColors.glassSurface;
  static const glassSurfaceMedium = InhaleColors.glassSurfaceMedium;
  static const glassSurfaceHeavy = InhaleColors.glassSurfaceHeavy;
  static const glassSurfaceLight = InhaleColors.glassSurfaceLight;
  static const glassSurfaceWhite = InhaleColors.glassSurfaceWhite;
  static const glassBorder = InhaleColors.glassBorder;
  static const glassBorderSubtle = InhaleColors.glassBorderSubtle;
  static const glassBorderHighlight = InhaleColors.glassBorderHighlight;
  static const glassShadow = InhaleColors.glassShadow;
  static const glassShadowBlue = InhaleColors.glassShadowBlue;

  // Ambient Lighting
  static const ambientBlue = InhaleColors.ambientBlue;
  static const ambientPink = InhaleColors.ambientPink;
  static const ambientSkyBlue = InhaleColors.ambientSkyBlue;

  // Light Theme
  static const lightBackground = InhaleColors.lightBackground;
  static const lightSurface = InhaleColors.lightSurface;
  static const lightGlassSurface = InhaleColors.lightGlassSurface;
  static const lightGlassSurfaceMedium = InhaleColors.lightGlassSurfaceMedium;
  static const lightGlassBorder = InhaleColors.lightGlassBorder;
  static const lightGlassBorderSubtle = InhaleColors.lightGlassBorderSubtle;
  static const lightTextPrimary = InhaleColors.lightTextPrimary;
  static const lightTextSecondary = InhaleColors.lightTextSecondary;
  static const lightTextMuted = InhaleColors.lightTextMuted;
  static const lightNavyText = InhaleColors.lightNavyText;
  static const lightSecondaryText = InhaleColors.lightSecondaryText;
  static const lightPrimaryBlue = InhaleColors.lightPrimaryBlue;
  static const lightDeepBlue = InhaleColors.lightDeepBlue;
  static const lightIceWhite = InhaleColors.lightIceWhite;
  static const lightBackgroundBlue = InhaleColors.lightBackgroundBlue;
  static const lightLightGlassBlue = InhaleColors.lightLightGlassBlue;
  static const lightSkyBlue = InhaleColors.lightSkyBlue;
  static const lightShadow = InhaleColors.lightShadow;

  // Legacy Aliases
  static const pureWhite = InhaleColors.pureWhite;
  static const primaryBlue = InhaleColors.primaryBlue;
  static const deepBlue = InhaleColors.deepBlue;
  static const navyText = InhaleColors.navyText;
  static const secondaryText = InhaleColors.secondaryText;
  static const iceWhite = InhaleColors.iceWhite;
  static const backgroundBlue = InhaleColors.backgroundBlue;
  static const lightGlassBlue = InhaleColors.lightGlassBlue;
  static const legacySkyBlue = InhaleColors.legacySkyBlue;
  static const darkBackground = InhaleColors.darkBackground;
  static const darkSurface = InhaleColors.darkSurface;
  static const darkGlassSurface = InhaleColors.darkGlassSurface;
  static const darkGlassBorder = InhaleColors.darkGlassBorder;
  static const darkNavyText = InhaleColors.darkNavyText;
  static const darkSecondaryText = InhaleColors.darkSecondaryText;
  static const darkPrimaryBlue = InhaleColors.darkPrimaryBlue;

  // Gradients
  static const gradientPrimary = InhaleColors.gradientPrimary;
  static const gradientAccent = InhaleColors.gradientAccent;
  static const gradientPink = InhaleColors.gradientPink;
  static const gradientBackgroundDark = InhaleColors.gradientBackgroundDark;
  static const gradientBackgroundLight = InhaleColors.gradientBackgroundLight;
  static const gradientBackground = InhaleColors.gradientBackground;
  static const gradientGlassOld = InhaleColors.gradientGlassOld;
  static const gradientGlass = InhaleColors.gradientGlass;
  static const gradientBackgroundOld = InhaleColors.gradientBackgroundOld;

  // Additional gradients for backward compatibility
  static const primaryGradient = InhaleColors.primaryGradient;
  static const primaryGradientDark = InhaleColors.primaryGradientDark;

  // Additional aliases used by UI widgets
  static const darkShadow = InhaleColors.lightShadow;
  static const lightShadowColor = InhaleColors.lightShadow;
  static const darkOutlineVariant = InhaleColors.glassBorderSubtle;
  static const lightOutlineVariant = InhaleColors.lightGlassBorderSubtle;
  static const darkTextTertiary = InhaleColors.textMuted;
  static const lightTextTertiary = InhaleColors.lightTextMuted;
  static const darkPrimary = InhaleColors.blue;
  static const lightPrimary = InhaleColors.lightPrimaryBlue;
  static const darkSurfaceContainer = InhaleColors.darkCharcoal;
  static const lightSurfaceContainer = InhaleColors.lightSurface;
  static const darkSurfaceVariant = InhaleColors.glassGrey;
  static const lightSurfaceVariant = InhaleColors.lightGlassSurface;
  static const darkSurfaceContainerLow = InhaleColors.darkCharcoal;
  static const darkSurfaceContainerHighest = InhaleColors.glassGrey;
  static const lightSurfaceContainerLow = InhaleColors.lightSurface;
  static const lightSurfaceContainerHighest =
      InhaleColors.lightGlassSurfaceMedium;

  // Deprecated aliases
  static const midnight = InhaleColors.midnight;
  static const darkNavy = InhaleColors.darkNavy;
  static const electricBlue = InhaleColors.electricBlue;
  static const softCyan = InhaleColors.softCyan;
  static const violet = InhaleColors.violet;
  static const violetSoft = InhaleColors.violetSoft;
  static const glassWhite = InhaleColors.glassWhite;
  static const ambientViolet = InhaleColors.ambientViolet;
  static const ambientCyan = InhaleColors.ambientCyan;
}
