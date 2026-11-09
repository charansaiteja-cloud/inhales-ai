import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';
import '../core/theme/inhale_typography.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? leading;
  final Widget? trailing;
  final double elevation;

  const GlassAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = false,
    this.onBack,
    this.leading,
    this.trailing,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: InhaleBlur.medium,
          sigmaY: InhaleBlur.medium,
        ),
        child: Container(
          decoration: BoxDecoration(
            color:
                isDark
                    ? InhaleColors.midnight.withValues(alpha: 0.8)
                    : InhaleColors.pureWhite.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color:
                    isDark
                        ? InhaleColors.glassBorderSubtle
                        : InhaleColors.lightGlassBorderSubtle,
                width: 0.5,
              ),
            ),
            boxShadow:
                elevation > 0
                    ? (isDark ? InhaleShadows.soft : InhaleShadows.glassBlue)
                    : null,
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InhaleSpacing.md,
                vertical: InhaleSpacing.sm,
              ),
              child: Row(
                children: [
                  if (showBack || leading != null)
                    leading ??
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color:
                                isDark
                                    ? InhaleColors.textPrimary
                                    : InhaleColors.lightNavyText,
                          ),
                          onPressed:
                              onBack ?? () => Navigator.of(context).pop(),
                        )
                  else
                    const SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      title,
                      style: InhaleTypography.titleLarge.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textPrimary
                                : InhaleColors.lightNavyText,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: showBack ? TextAlign.start : TextAlign.center,
                    ),
                  ),
                  trailing ??
                      (actions != null
                          ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [...actions!],
                          )
                          : const SizedBox(width: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
