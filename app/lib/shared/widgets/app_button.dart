/// InhaleSkill AI — Premium Shared Widgets
/// Core reusable components built on the new design system.
library;

import 'package:flutter/material.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';

// ============================================================================
// APP BUTTON
// ============================================================================

enum AppButtonVariant { primary, secondary, outlined, text, tonal }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final bool isDense;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final WidgetStateProperty<Color?>? overlayColor;
  final Duration animationDuration;

  const AppButton({
    super.key,
    this.label,
    this.icon,
    this.leadingIcon,
    this.trailingIcon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.isDense = false,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
    this.borderRadius,
    this.overlayColor,
    this.animationDuration = const Duration(milliseconds: 150),
  }) : assert(
         label != null || icon != null || leadingIcon != null,
         'Button must have at least a label, icon, or leadingIcon',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ?? _getBackgroundColor(cs, isDark);
    final effectiveForegroundColor =
        foregroundColor ?? _getForegroundColor(cs, isDark);
    final effectiveBorderSide = borderSide ?? _getBorderSide(cs, isDark);
    final effectiveBorderRadius = borderRadius ?? _getBorderRadius();
    final effectivePadding = padding ?? _getPadding();
    final effectiveMinSize = _getMinSize();
    final effectiveTextStyle = _getTextStyle(effectiveForegroundColor);

    Widget child = _buildChild(effectiveForegroundColor);

    final button = _buildButton(
      context,
      child,
      effectiveBackgroundColor,
      effectiveForegroundColor,
      effectiveBorderSide,
      effectiveBorderRadius,
      effectivePadding,
      effectiveMinSize,
      effectiveTextStyle,
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Color _getBackgroundColor(ColorScheme cs, bool isDark) {
    switch (variant) {
      case AppButtonVariant.primary:
        return cs.primary;
      case AppButtonVariant.secondary:
        return cs.secondaryContainer;
      case AppButtonVariant.outlined:
        return Colors.transparent;
      case AppButtonVariant.text:
        return Colors.transparent;
      case AppButtonVariant.tonal:
        return cs.tertiaryContainer;
    }
  }

  Color _getForegroundColor(ColorScheme cs, bool isDark) {
    switch (variant) {
      case AppButtonVariant.primary:
        return cs.onPrimary;
      case AppButtonVariant.secondary:
        return cs.onSecondaryContainer;
      case AppButtonVariant.outlined:
        return cs.primary;
      case AppButtonVariant.text:
        return cs.primary;
      case AppButtonVariant.tonal:
        return cs.onTertiaryContainer;
    }
  }

  BorderSide _getBorderSide(ColorScheme cs, bool isDark) {
    switch (variant) {
      case AppButtonVariant.primary:
        return BorderSide.none;
      case AppButtonVariant.secondary:
        return BorderSide.none;
      case AppButtonVariant.outlined:
        return BorderSide(color: cs.outline, width: 1.5);
      case AppButtonVariant.text:
        return BorderSide.none;
      case AppButtonVariant.tonal:
        return BorderSide.none;
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return BorderRadius.circular(AppRadius.buttonSmallRadius);
      case AppButtonSize.medium:
        return BorderRadius.circular(AppRadius.buttonRadius);
      case AppButtonSize.large:
        return BorderRadius.circular(AppRadius.buttonLargeRadius);
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        );
      case AppButtonSize.medium:
        return AppSpacing.buttonPaddingInsets;
      case AppButtonSize.large:
        return AppSpacing.buttonPaddingLargeInsets;
    }
  }

  Size _getMinSize() {
    switch (size) {
      case AppButtonSize.small:
        return const Size(0, 32);
      case AppButtonSize.medium:
        return const Size(0, 40);
      case AppButtonSize.large:
        return const Size(0, 48);
    }
  }

  TextStyle _getTextStyle(Color foregroundColor) {
    final baseStyle = switch (size) {
      AppButtonSize.small => AppTypography.buttonSmall,
      AppButtonSize.medium => AppTypography.buttonMedium,
      AppButtonSize.large => AppTypography.buttonLarge,
    };
    return baseStyle.copyWith(color: foregroundColor);
  }

  Widget _buildChild(Color foregroundColor) {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      );
    }

    final children = <Widget>[];

    if (leadingIcon != null) {
      children.add(leadingIcon!);
      children.add(SizedBox(width: AppSpacing.sm));
    } else if (icon != null) {
      children.add(icon!);
      if (label != null) {
        children.add(SizedBox(width: AppSpacing.sm));
      }
    }

    if (label != null) {
      children.add(
        Flexible(
          child: Text(
            label!,
            style: _getTextStyle(foregroundColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    if (trailingIcon != null) {
      children.add(SizedBox(width: AppSpacing.sm));
      children.add(trailingIcon!);
    }

    if (children.length == 1) {
      return children.first;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Widget _buildButton(
    BuildContext context,
    Widget child,
    Color backgroundColor,
    Color foregroundColor,
    BorderSide borderSide,
    BorderRadius borderRadius,
    EdgeInsetsGeometry padding,
    Size minSize,
    TextStyle textStyle,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget button;

    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor:
                isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.lightOutlineVariant,
            disabledForegroundColor:
                isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
            elevation: 0,
            shadowColor: Colors.transparent,
            padding: padding,
            minimumSize: minSize,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: borderSide,
            ),
            textStyle: textStyle,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ).copyWith(
            overlayColor:
                overlayColor ??
                WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.2);
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.1);
                  }
                  return null;
                }),
          ),
          child: child,
        );
        break;

      case AppButtonVariant.secondary:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor:
                isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.lightOutlineVariant,
            disabledForegroundColor:
                isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
            elevation: 0,
            padding: padding,
            minimumSize: minSize,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: borderSide,
            ),
            textStyle: textStyle,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: child,
        );
        break;

      case AppButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor:
                isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
            side: borderSide,
            padding: padding,
            minimumSize: minSize,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            textStyle: textStyle,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ).copyWith(
            overlayColor:
                overlayColor ??
                WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.1);
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.05);
                  }
                  return null;
                }),
          ),
          child: child,
        );
        break;

      case AppButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: foregroundColor,
            disabledForegroundColor:
                isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
            padding: padding,
            minimumSize: minSize,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            textStyle: textStyle,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ).copyWith(
            overlayColor:
                overlayColor ??
                WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.1);
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return (isDark
                            ? AppColors.darkPrimary
                            : AppColors.lightPrimary)
                        .withValues(alpha: 0.05);
                  }
                  return null;
                }),
          ),
          child: child,
        );
        break;

      case AppButtonVariant.tonal:
        button = FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            disabledBackgroundColor:
                isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.lightOutlineVariant,
            disabledForegroundColor:
                isDark
                    ? AppColors.darkTextTertiary
                    : AppColors.lightTextTertiary,
            elevation: 0,
            padding: padding,
            minimumSize: minSize,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: borderSide,
            ),
            textStyle: textStyle,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: child,
        );
        break;
    }

    return AnimatedScale(
      duration: animationDuration,
      scale: isLoading ? 0.98 : 1.0,
      child: button,
    );
  }
}

// ============================================================================
// APP ICON BUTTON
// ============================================================================

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final Color? disabledColor;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? splashColor;
  final double size;
  final double iconSize;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isSelected;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.backgroundColor,
    this.hoverColor,
    this.splashColor,
    this.size = 40,
    this.iconSize = 24,
    this.borderRadius,
    this.padding,
    this.isSelected = false,
    this.selectedColor,
    this.selectedBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final effectiveColor =
        color ??
        (isSelected ? (selectedColor ?? cs.primary) : cs.onSurfaceVariant);
    final effectiveDisabledColor =
        disabledColor ?? cs.onSurfaceVariant.withValues(alpha: 0.38);
    final effectiveBackgroundColor =
        backgroundColor ??
        (isSelected
            ? (selectedBackgroundColor ?? cs.primaryContainer)
            : Colors.transparent);
    final effectiveHoverColor = hoverColor ?? cs.surfaceContainerHighest;
    final effectiveSplashColor =
        splashColor ?? cs.primary.withValues(alpha: 0.1);
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppRadius.iconButtonRadius);

    final child = IconTheme(
      data: IconThemeData(
        color: onPressed != null ? effectiveColor : effectiveDisabledColor,
        size: iconSize,
      ),
      child: icon,
    );

    final button = Material(
      color: effectiveBackgroundColor,
      borderRadius: effectiveBorderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: effectiveBorderRadius,
        splashColor: effectiveSplashColor,
        hoverColor: effectiveHoverColor,
        child: SizedBox(width: size, height: size, child: Center(child: child)),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

// ============================================================================
// APP FAB
// ============================================================================

class AppFAB extends StatelessWidget {
  final Widget? icon;
  final String? label;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isExtended;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? extendedPadding;

  const AppFAB({
    super.key,
    this.icon,
    this.label,
    this.onPressed,
    this.tooltip,
    this.isExtended = false,
    this.backgroundColor,
    this.foregroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.elevation = 0,
    this.borderRadius,
    this.extendedPadding,
  }) : assert(icon != null || label != null, 'FAB must have icon or label');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final effectiveBg = backgroundColor ?? cs.primary;
    final effectiveFg = foregroundColor ?? cs.onPrimary;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppRadius.fab);

    Widget fab;
    if (isExtended && label != null) {
      fab = FloatingActionButton.extended(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: icon,
        label: Text(
          label!,
          style: AppTypography.buttonMedium.copyWith(color: effectiveFg),
        ),
        backgroundColor: effectiveBg,
        foregroundColor: effectiveFg,
        focusColor: focusColor,
        hoverColor: hoverColor,
        splashColor: splashColor,
        elevation: elevation,
        focusElevation: elevation,
        hoverElevation: elevation,
        highlightElevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
        extendedPadding:
            extendedPadding ??
            EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
      );
    } else {
      fab = FloatingActionButton(
        onPressed: onPressed,
        tooltip: tooltip,
        backgroundColor: effectiveBg,
        foregroundColor: effectiveFg,
        focusColor: focusColor,
        hoverColor: hoverColor,
        splashColor: splashColor,
        elevation: elevation,
        focusElevation: elevation,
        hoverElevation: elevation,
        highlightElevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: effectiveBorderRadius),
        child: icon ?? const Icon(Icons.add),
      );
    }

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: fab);
    }
    return fab;
  }
}
