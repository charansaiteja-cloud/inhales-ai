import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final double size;
  final Color? color;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 48,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (_) => onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: InhaleColors.glassSurface,
          shape: BoxShape.circle,
          border: Border.all(color: InhaleColors.glassBorderSubtle, width: 0.5),
        ),
        child: IconButton(icon: icon, onPressed: onTap),
      ),
    );
  }
}
