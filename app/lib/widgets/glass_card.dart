import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

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
    this.blur = 10.0,
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
    final radius = borderRadius ?? BorderRadius.circular(InhaleRadius.md);

    final effectiveShadows = shadows ?? _buildShadows(isDark);
    final effectiveBorder = borderColor ??
        (isDark
            ? InhaleColors.glassBorderSubtle
            : InhaleColors.lightGlassBorderSubtle);
    final effectiveBg = backgroundColor ??
        (isDark
            ? InhaleColors.glassSurfaceMedium
            : InhaleColors.lightGlassSurfaceMedium);

    final hoverCard = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: radius,
            border: Border.all(color: effectiveBorder, width: 0.5),
            boxShadow: effectiveShadows,
          ),
          child: shouldBlur
              ? ClipRRect(
                  borderRadius: radius,
                  child: RepaintBoundary(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                      child: _buildContent(context),
                    ),
                  ),
                )
              : _buildContent(context),
        ),
      ),
    );

    if (onTap != null || onLongPress != null) {
      return Semantics(
        button: true,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: radius,
          child: hoverCard,
        ),
      );
    }
    return hoverCard;
  }

  Widget _buildContent(BuildContext context) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child ?? const SizedBox(),
      );

  List<BoxShadow> _buildShadows(bool isDark) {
    if (glow) {
      return isDark
          ? [
              BoxShadow(
                color: InhaleColors.blue.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ]
          : [];
    }
    if (elevated) {
      return isDark
          ? [
              BoxShadow(
                color: InhaleColors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]
          : [
              BoxShadow(
                color: InhaleColors.blue.withValues(alpha: 0.15),
                blurRadius: 10,
              ),
            ];
    }
    return [];
  }
}
