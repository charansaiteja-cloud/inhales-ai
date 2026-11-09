import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

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
  final bool disabled;

  const GlassButton({
    super.key,
    this.onTap,
    this.child,
    this.label,
    this.width,
    this.height,
    this.outlined = false,
    this.iconOnly = false,
    this.blur = InhaleBlur.reduced,
    this.enabled = true,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final content =
        child ??
        Text(
          label ?? '',
          style: TextStyle(
            color: outlined ? InhaleColors.primaryBlue : InhaleColors.pureWhite,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        );

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: TapRegion(
        onTapInside: (_) => onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          width: width,
          height: height ?? (iconOnly ? 48 : 52),
          decoration: BoxDecoration(
            color:
                enabled
                    ? (outlined
                        ? InhaleColors.glassSurface
                        : InhaleColors.pureWhite.withValues(alpha: 0.9))
                    : InhaleColors.glassSurface,
            gradient:
                enabled && !outlined ? InhaleColors.gradientPrimary : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(InhaleRadius.pill),
            ),
            border: Border.all(
              color:
                  outlined
                      ? InhaleColors.primaryBlue
                      : InhaleColors.glassBorderSubtle,
              width: outlined ? 1.5 : 0.5,
            ),
            boxShadow:
                enabled
                    ? (outlined
                        ? InhaleShadows.soft
                        : InhaleShadows.floating)
                    : null,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(InhaleRadius.pill),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }
}
