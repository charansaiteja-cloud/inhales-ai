import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Premium Liquid Glass button with frosted blur and gradient.
class GlassButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final String? label;
  final double? width;
  final double? height;
  final bool outlined;
  final bool iconOnly;
  final double blur;
  final bool enabled;
  final bool glow;
  final BorderRadius? borderRadius;

  const GlassButton({
    super.key,
    this.onTap,
    this.child,
    this.label,
    this.width,
    this.height,
    this.outlined = false,
    this.iconOnly = false,
    this.blur = InhaleBlur.light,
    this.enabled = true,
    this.glow = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius =
        borderRadius ??
        const BorderRadius.all(Radius.circular(InhaleRadius.pill));

    final content =
        child ??
        Text(
          label ?? '',
          style: TextStyle(
            color:
                outlined
                    ? (isDark
                        ? InhaleColors.blue
                        : InhaleColors.lightPrimaryBlue)
                    : (isDark ? InhaleColors.textPrimary : Colors.white),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        );

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Semantics(
        button: true,
        enabled: enabled,
        label: label ?? 'Button',
        onTap: enabled ? onTap : null,
        child: FocusableActionDetector(
          enabled: enabled,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: effectiveRadius,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: width,
              height: height ?? (iconOnly ? 44 : 48),
              decoration: BoxDecoration(
                color:
                    enabled
                        ? (outlined
                            ? InhaleColors.glassSurface
                            : (isDark
                                ? InhaleColors.blue
                                : InhaleColors.lightPrimaryBlue))
                        : (isDark
                            ? InhaleColors.glassSurface
                            : InhaleColors.lightGlassSurface),
                gradient:
                    enabled && !outlined ? InhaleColors.gradientPrimary : null,
                borderRadius: effectiveRadius,
                border: Border.all(
                  color:
                      outlined
                          ? (isDark
                              ? InhaleColors.glassBorder
                              : InhaleColors.lightGlassBorder)
                          : (isDark
                              ? InhaleColors.glassBorderSubtle
                              : InhaleColors.lightGlassBorderSubtle),
                  width: outlined ? 1.5 : 0.5,
                ),
                boxShadow:
                    enabled
                        ? (glow
                            ? InhaleShadows.glowBlue
                            : (outlined
                                ? InhaleShadows.soft
                                : InhaleShadows.floating))
                        : null,
              ),
              child: ClipRRect(
                borderRadius: effectiveRadius,
                child: RepaintBoundary(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                    child: Center(child: content),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
