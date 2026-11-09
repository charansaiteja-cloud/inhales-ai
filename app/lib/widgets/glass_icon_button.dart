import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_tokens.dart';

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final Color? color;
  final bool useBlur;

  const GlassIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 48,
    this.color,
    this.useBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor =
        color ?? (isDark ? Colors.white : Colors.grey.shade800);

    return Semantics(
      button: true,
      label: 'Button with icon',
      onTap: onTap,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.white24,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.grey.shade400,
              width: 0.5,
            ),
          ),
          child: ClipOval(
            child:
                useBlur
                    ? RepaintBoundary(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: InhaleBlur.light,
                          sigmaY: InhaleBlur.light,
                        ),
                        child: IconButton(
                          icon: Icon(icon, color: effectiveColor),
                          onPressed: onTap,
                          iconSize: size * 0.6,
                        ),
                      ),
                    )
                    : IconButton(
                      icon: Icon(icon, color: effectiveColor),
                      onPressed: onTap,
                      iconSize: size * 0.6,
                    ),
          ),
        ),
      ),
    );
  }
}
