import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Reusable frosted-glass card.
class GlassCard extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final bool elevated;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;

  const GlassCard({
    super.key,
    this.child,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.blur = InhaleBlur.light,
    this.elevated = false,
    this.backgroundColor,
    this.borderRadius,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? const BorderRadius.all(
      Radius.circular(InhaleRadius.md),
    );

    final effectiveShadows = shadows ??
        (elevated ? InhaleShadows.glass : InhaleShadows.softBlue);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? InhaleColors.glassSurface,
        borderRadius: radius,
        border: Border.all(
          color: InhaleColors.glassBorderSubtle,
          width: 0.5,
        ),
        boxShadow: effectiveShadows,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Material(
            color: Colors.transparent,
            child: onTap != null || onLongPress != null
                ? GlassInkTap(
                    onTap: onTap,
                    onLongPress: onLongPress,
                    child: padding != null
                        ? Padding(padding: padding!, child: child)
                        : child,
                  )
                : padding != null
                    ? Padding(padding: padding!, child: child)
                    : child,
          ),
        ),
      ),
    );
  }
}

/// Internal ink-well wrapper preserving glass styling on press.
class GlassInkTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const GlassInkTap({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
  });

  @override
  State<GlassInkTap> createState() => _GlassInkTapState();
}

class _GlassInkTapState extends State<GlassInkTap> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _pressed = true),
      onExit: (_) => setState(() => _pressed = false),
      child: TapRegion(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: _pressed
                ? InhaleColors.glassSurfaceHeavy
                : InhaleColors.glassSurface,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}