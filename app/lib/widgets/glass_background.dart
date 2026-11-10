import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

/// Liquid Glass background with ambient lighting effects.
class GlassBackground extends StatelessWidget {
  final Widget child;
  final bool showAmbientLighting;
  final bool useGradient;

  const GlassBackground({
    super.key,
    required this.child,
    this.showAmbientLighting = true,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient:
            useGradient
                ? (isDark
                    ? InhaleColors.gradientBackgroundDark
                    : InhaleColors.gradientBackground)
                : null,
        color:
            useGradient
                ? null
                : (isDark ? InhaleColors.black : InhaleColors.lightBackground),
      ),
      child: Stack(
        children: [
          if (showAmbientLighting && isDark) ...[
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: InhaleColors.ambientBlue,
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: InhaleColors.ambientPink,
                ),
              ),
            ),
          ],
          child,
        ],
      ),
    );
  }
}
