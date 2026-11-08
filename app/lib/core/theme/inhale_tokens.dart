import 'package:flutter/material.dart';
import 'inhale_colors.dart';

/// InhaleSkill AI — Design tokens: spacing, radius, blur, shadows.
class InhaleSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

class InhaleRadius {
  static const double sm = 12;
  static const double md = 20;
  static const double lg = 28;
  static const double xl = 40;
  static const double pill = 999;
  static const double circle = 999;
}

class InhaleBlur {
  static const double light = 8;
  static const double medium = 16;
  static const double heavy = 24;
  static const double reduced = 4; // for reduced-blur mode
}

class InhaleShadows {
  static const List<BoxShadow> softBlue = [
    BoxShadow(
      color: Color(0x1F559BEB),
      blurRadius: 20,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> glass = [
    BoxShadow(
      color: Color(0x14559BEB),
      blurRadius: 24,
      offset: Offset(0, 12),
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x1F2463C9),
      blurRadius: 32,
      offset: Offset(0, 16),
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color(0x0F142D50),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];
}
