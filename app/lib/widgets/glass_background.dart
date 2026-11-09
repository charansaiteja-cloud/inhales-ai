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
    return Container(
      decoration: BoxDecoration(
        gradient: useGradient ? InhaleColors.gradientBackground : null,
        color: useGradient ? null : InhaleColors.pureWhite,
      ),
      child: child,
    );
  }
}
