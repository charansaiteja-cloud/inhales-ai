import 'package:flutter/material.dart';

/// InhaleSkill AI — Design tokens: spacing, radius, blur, shadows.
class InhaleSpacing {
  InhaleSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

class InhaleRadius {
  InhaleRadius._();
  static const double xs = 10;
  static const double sm = 14;
  static const double md = 20;
  static const double lg = 28;
  static const double xl = 36;
  static const double pill = 999;
  static const double circle = 999;
}

class InhaleBlur {
  InhaleBlur._();
  static const double light = 10;
  static const double medium = 16;
  static const double heavy = 24;
  static const double ultra = 32;
  static const double reduced = 2; // for reduced-blur mode
}

class InhaleOpacity {
  InhaleOpacity._();
  static const double glassLight = 0.08;
  static const double glassMedium = 0.15;
  static const double glassHeavy = 0.25;
  static const double borderSubtle = 0.1;
  static const double border = 0.2;
  static const double borderHighlight = 0.3;
}

class InhaleShadows {
  InhaleShadows._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> glass = [
    BoxShadow(
      color: Color(0x14080B16),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> glassBlue = [
    BoxShadow(
      color: Color(0x145B8CFF),
      blurRadius: 28,
      offset: Offset(0, 10),
      spreadRadius: -6,
    ),
  ];

  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x1A080B16),
      blurRadius: 36,
      offset: Offset(0, 16),
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: -1,
    ),
  ];

  static const List<BoxShadow> glowBlue = [
    BoxShadow(
      color: Color(0x265B8CFF),
      blurRadius: 40,
      offset: Offset(0, 0),
      spreadRadius: 2,
    ),
  ];

  static const List<BoxShadow> glowViolet = [
    BoxShadow(
      color: Color(0x1A9B87FF),
      blurRadius: 40,
      offset: Offset(0, 0),
      spreadRadius: 2,
    ),
  ];
}
