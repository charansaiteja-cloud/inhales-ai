import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
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
        color ??
        (isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText);

    return TapRegion(
      onTapInside: (_) => onTap?.call(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              isDark
                  ? InhaleColors.glassSurfaceLight
                  : InhaleColors.lightGlassSurface,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                isDark
                    ? InhaleColors.glassBorderSubtle
                    : InhaleColors.lightGlassBorderSubtle,
            width: 0.5,
          ),
          boxShadow: isDark ? InhaleShadows.subtle : null,
        ),
        child: ClipOval(
          child:
              useBlur
                  ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: InhaleBlur.light,
                      sigmaY: InhaleBlur.light,
                    ),
                    child: IconButton(
                      icon: Icon(icon, color: effectiveColor),
                      onPressed: onTap,
                    ),
                  )
                  : IconButton(
                    icon: Icon(icon, color: effectiveColor),
                    onPressed: onTap,
                  ),
        ),
      ),
    );
  }
}
