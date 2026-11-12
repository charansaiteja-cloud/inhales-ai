import 'package:flutter/widgets.dart';

enum Breakpoint { mobile, tablet, desktop }

class Responsive {
  static Breakpoint of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) return Breakpoint.desktop;
    if (width >= 600) return Breakpoint.tablet;
    return Breakpoint.mobile;
  }

  static bool isDesktop(BuildContext ctx) => of(ctx) == Breakpoint.desktop;
  static bool isTablet(BuildContext ctx) => of(ctx) == Breakpoint.tablet;
  static bool isMobile(BuildContext ctx) => of(ctx) == Breakpoint.mobile;
}
