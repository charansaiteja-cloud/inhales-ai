import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassStatusBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final BadgeVariant variant;

  const GlassStatusBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.variant = BadgeVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bgColor;
    Color txtColor;

    switch (variant) {
      case BadgeVariant.primary:
        bgColor =
            isDark
                ? InhaleColors.blue.withValues(alpha: 0.2)
                : InhaleColors.blue.withValues(alpha: 0.15);
        txtColor = isDark ? InhaleColors.blue : InhaleColors.lightPrimaryBlue;
        break;
      case BadgeVariant.success:
        bgColor =
            isDark
                ? InhaleColors.success.withValues(alpha: 0.2)
                : InhaleColors.success.withValues(alpha: 0.15);
        txtColor = InhaleColors.success;
        break;
      case BadgeVariant.warning:
        bgColor =
            isDark
                ? InhaleColors.warning.withValues(alpha: 0.2)
                : InhaleColors.warning.withValues(alpha: 0.15);
        txtColor = InhaleColors.warning;
        break;
      case BadgeVariant.error:
        bgColor =
            isDark
                ? InhaleColors.error.withValues(alpha: 0.2)
                : InhaleColors.error.withValues(alpha: 0.15);
        txtColor = InhaleColors.error;
        break;
      case BadgeVariant.pink:
        bgColor =
            isDark
                ? InhaleColors.pink.withValues(alpha: 0.2)
                : InhaleColors.pink.withValues(alpha: 0.15);
        txtColor = isDark ? InhaleColors.pink : InhaleColors.pink;
        break;
      case BadgeVariant.skyBlue:
        bgColor =
            isDark
                ? InhaleColors.skyBlue.withValues(alpha: 0.2)
                : InhaleColors.skyBlue.withValues(alpha: 0.15);
        txtColor = isDark ? InhaleColors.skyBlue : InhaleColors.skyBlue;
        break;
      case BadgeVariant.custom:
        bgColor =
            backgroundColor ??
            (isDark
                ? InhaleColors.glassSurface
                : InhaleColors.lightGlassSurface);
        txtColor =
            textColor ??
            (isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: txtColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum BadgeVariant { primary, success, warning, error, pink, skyBlue, custom }
