import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Premium Liquid Glass card with frosted blur and optional elevation/glow.
///
/// A [StatefulWidget] that tracks keyboard focus and renders a subtle blue
/// focus outline when the user navigates to it via Tab/Shift+Tab.
class GlassCard extends StatefulWidget {
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
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = MediaQuery.of(context).accessibleNavigation;
    final shouldBlur = widget.useBlur ?? !settings;
    final radius =
        widget.borderRadius ?? BorderRadius.circular(InhaleRadius.md);
    final effectiveShadows = widget.shadows ?? _buildShadows(isDark);
    final effectiveBorder = widget.borderColor ??
        (isDark
            ? InhaleColors.glassBorderSubtle
            : InhaleColors.lightGlassBorderSubtle);
    final effectiveBg = widget.backgroundColor ??
        (isDark
            ? InhaleColors.glassSurfaceMedium
            : InhaleColors.lightGlassSurfaceMedium);

    final hoverCard = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: radius,
            border: _hasFocus
                ? Border.all(color: InhaleColors.blue, width: 2.0)
                : Border.all(color: effectiveBorder, width: 0.5),
            boxShadow: effectiveShadows,
          ),
          child: shouldBlur
              ? ClipRRect(
                  borderRadius: radius,
                  child: RepaintBoundary(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: widget.blur,
                        sigmaY: widget.blur,
                      ),
                      child: _buildContent(context),
                    ),
                  ),
                )
              : _buildContent(context),
        ),
      ),
    );

    if (widget.onTap != null || widget.onLongPress != null) {
      return Semantics(
        button: true,
        child: FocusableActionDetector(
          onShowFocusHighlight: (v) => setState(() => _hasFocus = v),
          child: hoverCard,
        ),
      );
    }
    return hoverCard;
  }

  Widget _buildContent(BuildContext context) => Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: widget.child ?? const SizedBox(),
      );

  List<BoxShadow> _buildShadows(bool isDark) {
    if (widget.glow) {
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
    if (widget.elevated) {
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
