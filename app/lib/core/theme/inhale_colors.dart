/// InhaleSkill AI — Liquid Glass Colour Palette.
/// Centralised colour definitions. Never hardcode colours elsewhere.
///
/// Dark mode is the primary visual identity.
/// Deep midnight navy with electric blue and violet accents.
library;

import 'package:flutter/material.dart';

class InhaleColors {
  InhaleColors._();

  // ── Core Identity ──────────────────────────────────────
  static const midnight = Color(0xFF080B16);
  static const darkNavy = Color(0xFF10172A);
  static const deepNavy = Color(0xFF182040);
  static const electricBlue = Color(0xFF5B8CFF);
  static const softCyan = Color(0xFF7DE7FF);
  static const violet = Color(0xFF9B87FF);
  static const violetSoft = Color(0xFF7A65E0);
  static const glassWhite = Color(0xFFFFFFFF);

  // ── Text ───────────────────────────────────────────────
  static const textPrimary = Color(0xFFF0F4FF);
  static const textSecondary = Color(0xFFA5AEC3);
  static const textMuted = Color(0xFF6B7590);
  static const textOnGlass = Color(0xE6F0F4FF);
  static const textOnGlassSecondary = Color(0x99A5AEC3);

  // ── Semantic ───────────────────────────────────────────
  static const success = Color(0xFF2ECC71);
  static const successSoft = Color(0x1A2ECC71);
  static const warning = Color(0xFFF1C40F);
  static const warningSoft = Color(0x1AF1C40F);
  static const error = Color(0xFFE74C3C);
  static const errorSoft = Color(0x1AE74C3C);
  static const info = Color(0xFF3498DB);

  // ── Glass Surfaces (Dark) ──────────────────────────────
  static const glassSurface = Color(0x1A182040); // 10% deep navy
  static const glassSurfaceMedium = Color(0x29182040); // 16% deep navy
  static const glassSurfaceHeavy = Color(0x40182040); // 25% deep navy
  static const glassSurfaceLight = Color(0x0F182040); // 6% deep navy
  static const glassSurfaceWhite = Color(0x0DFFFFFF); // 5% white
  static const glassBorder = Color(0x33FFFFFF); // 20% white border
  static const glassBorderSubtle = Color(0x1AFFFFFF); // 10% white border
  static const glassBorderHighlight = Color(0x4DFFFFFF); // 30% top highlight
  static const glassShadow = Color(0x1A080B16); // deep shadow
  static const glassShadowBlue = Color(0x145B8CFF); // blue-tinted shadow

  // ── Ambient Lighting ───────────────────────────────────
  static const ambientBlue = Color(0x145B8CFF); // 8% electric blue
  static const ambientViolet = Color(0x0D9B87FF); // 5% violet
  static const ambientCyan = Color(0x0A7DE7FF); // 4% cyan

  // ── Light Theme ────────────────────────────────────────
  static const lightBackground = Color(0xFFF4F7FF);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightGlassSurface = Color(0x99FFFFFF); // 60% white
  static const lightGlassSurfaceMedium = Color(0xCCFFFFFF); // 80% white
  static const lightGlassBorder = Color(0x4DFFFFFF); // 30% white border
  static const lightGlassBorderSubtle = Color(0x26FFFFFF);
  static const lightTextPrimary = Color(0xFF142D50);
  static const lightTextSecondary = Color(0xFF71849B);
  static const lightTextMuted = Color(0xFF9AACBD);
  static const lightNavyText = Color(0xFF142D50);
  static const lightSecondaryText = Color(0xFF71849B);
  static const lightPrimaryBlue = Color(0xFF5B8CFF);
  static const lightDeepBlue = Color(0xFF2463C9);
  static const lightIceWhite = Color(0xFFF4F9FF);
  static const lightBackgroundBlue = Color(0xFFEAF4FF);
  static const lightLightGlassBlue = Color(0xFFDCEEFF);
  static const lightSkyBlue = Color(0xFFA8D4FF);
  static const lightShadow = Color(0x0F142D50);

  // ── Legacy aliases (backward compat) ──────────────────
  static const pureWhite = glassWhite;
  static const primaryBlue = electricBlue;
  static const deepBlue = Color(0xFF2463C9);
  static const navyText = lightNavyText;
  static const secondaryText = lightTextSecondary;
  static const iceWhite = lightIceWhite;
  static const backgroundBlue = lightBackgroundBlue;
  static const lightGlassBlue = lightLightGlassBlue;
  static const skyBlue = lightSkyBlue;
  static const darkBackground = midnight;
  static const darkSurface = darkNavy;
  static const darkGlassSurface = glassSurfaceMedium;
  static const darkGlassBorder = glassBorderSubtle;
  static const darkNavyText = textPrimary;
  static const darkSecondaryText = textSecondary;
  static const darkPrimaryBlue = electricBlue;

  // ── Gradients ──────────────────────────────────────────
  static const gradientPrimary = LinearGradient(
    colors: [electricBlue, violetSoft],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientAccent = LinearGradient(
    colors: [softCyan, electricBlue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientViolet = LinearGradient(
    colors: [violet, electricBlue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBackgroundDark = LinearGradient(
    colors: [midnight, darkNavy, deepNavy],
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

  // Backward compat alias
  static const gradientBackground = gradientBackgroundLight;

  // Legacy gradients for backward compatibility
  static const gradientGlassOld = LinearGradient(
    colors: [Color(0xCCFFFFFF), Color(0x99DCEEFF)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientGlass = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x0D5B8CFF)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Legacy alias for backward compatibility
  static const gradientBackgroundOld = gradientBackgroundLight;
}
