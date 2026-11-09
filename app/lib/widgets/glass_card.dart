import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Premium Liquid Glass card with frosted blur effect.
/// Automatically adapts to light/dark theme.
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
  final bool glow;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final bool? useBlur;

  const GlassCard({
    super.key,
    this.child,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.blur = InhaleBlur.medium,
    this.elevated = false,
    this.glow = false,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.shadows,
    this.useBlur,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = MediaQuery.of(context).accessibleNavigation;
    final shouldBlur = useBlur ?? !settings;
    final radius =
        borderRadius ??
        const BorderRadius.all(Radius.circular(InhaleRadius.md));

    final effectiveShadows = shadows ?? _buildShadows(isDark);
    final effectiveBorder =
        borderColor ??
        (isDark
            ? InhaleColors.glassBorderSubtle
            : InhaleColors.lightGlassBorderSubtle);
    final effectiveBg =
        backgroundColor ??
        (isDark
            ? InhaleColors.glassSurfaceMedium
            : InhaleColors.lightGlassSurface);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: radius,
        border: Border.all(color: effectiveBorder, width: 0.5),
        boxShadow: effectiveShadows,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child:
            shouldBlur
                ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: _buildContent(context),
                )
                : _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child ?? const SizedBox(),
    );

    return Material(
      color: Colors.transparent,
      child:
          onTap != null || onLongPress != null
              ? InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                borderRadius:
                    borderRadius ??
                    const BorderRadius.all(Radius.circular(InhaleRadius.md)),
                child: content,
              )
              : content,
    );
  }

  List<BoxShadow> _buildShadows(bool isDark) {
    if (glow) {
      return isDark ? InhaleShadows.glowBlue : InhaleShadows.subtle;
    }
    if (elevated) {
      return isDark ? InhaleShadows.floating : InhaleShadows.glassBlue;
    }
    return isDark ? InhaleShadows.glass : InhaleShadows.soft;
  }
}
