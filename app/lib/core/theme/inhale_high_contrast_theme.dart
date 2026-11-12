import 'package:flutter/material.dart';
import 'inhale_colors.dart';

class InhaleHighContrastTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: InhaleColors.black,
    colorScheme: const ColorScheme.dark(
      primary: InhaleColors.blue,
      secondary: InhaleColors.pink,
      surface: InhaleColors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
    ),
    // Force a slightly darker glass surface so AA contrast is guaranteed
    // (24 % opacity instead of 16 %).
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: InhaleColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: InhaleColors.lightPrimaryBlue,
      secondary: InhaleColors.lightSkyBlue,
      surface: InhaleColors.lightBackground,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: InhaleColors.lightNavyText),
      bodyMedium: TextStyle(color: InhaleColors.lightNavyText),
      titleLarge: TextStyle(color: InhaleColors.lightNavyText),
      headlineLarge: TextStyle(color: InhaleColors.lightNavyText),
    ),
  );
}
