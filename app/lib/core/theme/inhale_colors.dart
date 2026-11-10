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
  static const textPrimary = Color(0xFFF8FAFC); // frostWhite
  static const textSecondary = Color(0xFFBAE6FD); // iceBlue
  static const textMuted = Color(0xFF7DD3FC); // lighter skyBlue
  static const textOnGlass = Color(0xE6F8FAFC);
  static const textOnGlassSecondary = Color(0x99BAE6FD);

  // ── Glass Surfaces (Black Theme) ────────────────────────
  static const glassSurface = Color(0x1A262626); // 10% glassGrey
  static const glassSurfaceMedium = Color(0x29262626); // 16% glassGrey
  static const glassSurfaceHeavy = Color(0x40262626); // 25% glassGrey
  static const glassSurfaceLight = Color(0x0F262626); // 6% glassGrey
  static const glassSurfaceWhite = Color(0x0DFFFFFF); // 5% white
  static const glassBorder = Color(0x33FFFFFF); // 20% white border
  static const glassBorderSubtle = Color(0x1AFFFFFF); // 10% white border
  static const glassBorderHighlight = Color(0x4DFFFFFF); // 30% top highlight
  static const glassShadow = Color(0x1A050505); // deep shadow
  static const glassShadowBlue = Color(0x141677D2); // blue-tinted shadow

  // ── Ambient Lighting ────────────────────────────────────
  static const ambientBlue = Color(0x141677D2); // 8% blue
  static const ambientPink = Color(0x0DEC4899); // 5% pink
  static const ambientSkyBlue = Color(0x0A38BDF8); // 4% skyBlue

  // ── Light Theme ─────────────────────────────────────────
  static const lightBackground = Color(0xFFF8FAFC); // frostWhite
  static const lightSurface = Color(0xFFFFFFFF); // pure white
  static const lightGlassSurface = Color(0x99FFFFFF); // 60% white
  static const lightGlassSurfaceMedium = Color(0xCCFFFFFF); // 80% white
  static const lightGlassBorder = Color(0x4DFFFFFF); // 30% white border
  static const lightGlassBorderSubtle = Color(0x26FFFFFF);
  static const lightTextPrimary = Color(0xFF0B1F3A); // deepNavy
  static const lightTextSecondary = Color(0xFF1677D2); // blue
  static const lightTextMuted = Color(0xFF38BDF8); // skyBlue
  static const lightNavyText = Color(0xFF0B1F3A);
  static const lightSecondaryText = Color(0xFF1677D2);
  static const lightPrimaryBlue = Color(0xFF1677D2);
  static const lightDeepBlue = Color(0xFF0B1F3A);
  static const lightIceWhite = Color(0xFFF8FAFC);
  static const lightBackgroundBlue = Color(0xFFE0F2FE); // light skyBlue
  static const lightLightGlassBlue = Color(0xFFBAE6FD); // iceBlue
  static const lightSkyBlue = Color(0xFF38BDF8);
  static const lightShadow = Color(0x0F0B1F3A);

  // ── Legacy Aliases (Backward Compat) ────────────────────
  // These map to the new palette so existing code compiles unchanged.
  static const pureWhite = frostWhite;
  static const primaryBlue = blue;
  static const deepBlue = deepNavy;
  static const navyText = lightNavyText;
  static const secondaryText = lightTextSecondary;
  static const iceWhite = lightIceWhite;
  static const backgroundBlue = lightBackgroundBlue;
  static const lightGlassBlue = lightLightGlassBlue;
  static const legacySkyBlue =
      lightSkyBlue; // skyBlue already defined in Accent Palette
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

  // Backward compat alias
  static const gradientBackground = gradientBackgroundLight;

  // Legacy gradients for backward compatibility
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

  // Legacy alias for backward compatibility
  static const gradientBackgroundOld = gradientBackgroundLight;

  // ── Deprecated aliases (keep for any stray refs) ────────
  // Map old midnight/navy/violet/cyan names to new palette
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
