import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Premium Liquid Glass button with frosted blur and gradient.
///
/// Now a [StatefulWidget] that tracks focus state and renders a blue focus
/// ring when navigated to via keyboard (Tab/Shift+Tab).
class GlassButton extends StatefulWidget {
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
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveRadius = widget.borderRadius ??
        const BorderRadius.all(Radius.circular(InhaleRadius.pill));
    final content = widget.child ??
        Text(
          widget.label ?? '',
          style: TextStyle(
            color: widget.outlined
                ? (isDark ? InhaleColors.blue : InhaleColors.lightPrimaryBlue)
                : (isDark ? InhaleColors.textPrimary : Colors.white),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        );

    return MouseRegion(
      cursor:
          widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Semantics(
        button: true,
        enabled: widget.enabled,
        label: widget.label ?? 'Button',
        child: FocusableActionDetector(
          enabled: widget.enabled,
          onShowFocusHighlight: (v) => setState(() => _hasFocus = v),
          child: InkWell(
            onTap: widget.enabled ? widget.onTap : null,
            borderRadius: effectiveRadius,
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 150), // faster press animation
              curve: Curves.easeInOut,
              width: widget.width,
              height: widget.height ?? (widget.iconOnly ? 44 : 48),
              decoration: BoxDecoration(
                color: widget.enabled
                    ? (widget.outlined
                        ? InhaleColors.glassSurface.withValues(alpha: 0.24)
                        : (isDark
                            ? InhaleColors.blue
                            : InhaleColors.lightPrimaryBlue))
                    : (isDark
                        ? InhaleColors.glassSurface.withValues(alpha: 0.24)
                        : InhaleColors.lightGlassSurface),
                gradient: widget.enabled && !widget.outlined
                    ? InhaleColors.gradientPrimary
                    : null,
                borderRadius: effectiveRadius,
                border: Border.all(
                  color: _hasFocus
                      ? InhaleColors.blue
                      : (widget.outlined
                          ? (isDark
                              ? InhaleColors.glassBorder
                              : InhaleColors.lightGlassBorder)
                          : (isDark
                              ? InhaleColors.glassBorderSubtle
                              : InhaleColors.lightGlassBorderSubtle)),
                  width: _hasFocus ? 2.0 : (widget.outlined ? 1.5 : 0.5),
                ),
                // NEW: visual focus ring when keyboard focused
                boxShadow: widget.enabled
                    ? (widget.glow
                        ? InhaleShadows.glowBlue
                        : (widget.outlined
                            ? InhaleShadows.soft
                            : InhaleShadows.floating))
                    : null,
              ),
              child: ClipRRect(
                borderRadius: effectiveRadius,
                child: RepaintBoundary(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: widget.blur,
                      sigmaY: widget.blur,
                    ),
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
