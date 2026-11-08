import 'package:flutter/widgets.dart';

class Responsive {
  const Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 720;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 720 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static int crossAxisCount(BuildContext context,
      {int mobile = 2, int tablet = 3, int desktop = 4}) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet;
    return mobile;
  }
}