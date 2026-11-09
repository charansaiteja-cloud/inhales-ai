import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassBackground extends StatelessWidget {
  final Widget child;
  final bool useGradient;

  const GlassBackground({
    super.key,
    required this.child,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: useGradient
            ? (isDark
                ? InhaleColors.gradientBackgroundDark
                : InhaleColors.gradientBackground)
            : null,
        color: useGradient
            ? null
            : (isDark ? InhaleColors.midnight : InhaleColors.pureWhite),
      ),
      child: child,
    );
  }
}
