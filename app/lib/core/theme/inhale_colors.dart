/// InhaleSkill AI — Blue & White Liquid Glass Colour Palette.
/// Centralised colour definitions. Never hardcode colours elsewhere.
import 'package:flutter/material.dart';

class InhaleColors {
  // Pure / base
  static const pureWhite = Color(0xFFFFFFFF);
  static const iceWhite = Color(0xFFF4F9FF);
  static const backgroundBlue = Color(0xFFEAF4FF);
  static const lightGlassBlue = Color(0xFFDCEEFF);
  static const skyBlue = Color(0xFFA8D4FF);

  // Primary scale
  static const primaryBlue = Color(0xFF559BEB);
  static const deepBlue = Color(0xFF2463C9);
  static const navyText = Color(0xFF142D50);
  static const secondaryText = Color(0xFF71849B);
  static const textPrimary = Color(0xFF142D50); // alias for navyText

  // Semantic
  static const success = Color(0xFF2ECC71);
  static const warning = Color(0xFFF1C40F);
  static const error = Color(0xFFE74C3C);
  static const info = Color(0xFF3498DB);

  // Glass surfaces
  static const glassSurface = Color(0x99FFFFFF); // 60% white
  static const glassSurfaceHeavy = Color(0xCCFFFFFF); // 80% white
  static const glassSurfaceLight = Color(0x66FFFFFF); // 40% white
  static const glassBorder = Color(0x99FFFFFF); // translucent white border
  static const glassBorderSubtle = Color(0x4DFFFFFF);
  static const glassShadow = Color(0x1F559BEB); // soft blue shadow

  // Dark theme equivalents
  static const darkBackground = Color(0xFF0B1A33);
  static const darkSurface = Color(0xFF142A4A);
  static const darkGlassSurface = Color(0x66142A4A);
  static const darkGlassBorder = Color(0x33A8D4FF);
  static const darkNavyText = Color(0xFFF0F5FF);
  static const darkSecondaryText = Color(0xFF8FA6C4);
  static const darkPrimaryBlue = Color(0xFF559BEB);

  // Gradients
  static const gradientBackground = LinearGradient(
    colors: [backgroundBlue, iceWhite, pureWhite],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientGlass = LinearGradient(
    colors: [Color(0xCCFFFFFF), Color(0x99DCEEFF)],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientPrimary = LinearGradient(
    colors: [primaryBlue, deepBlue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientAccent = LinearGradient(
    colors: [skyBlue, primaryBlue],
    stops: [0.0, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}