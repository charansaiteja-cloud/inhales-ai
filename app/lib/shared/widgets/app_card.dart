/// InhaleSkill AI — Premium Shared Widgets
/// Card, TextField, and Surface components
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show TextInputFormatter, MaxLengthEnforcement;

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';

// ============================================================================
// APP CARD
// ============================================================================

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? surfaceTintColor;
  final List<BoxShadow>? shadows;
  final BorderRadius? borderRadius;
  final Border? border;
  final bool isHoverable;
  final bool isSelected;
  final Color? selectedColor;
  final Color? selectedBorderColor;
  final Duration animationDuration;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.color,
    this.surfaceTintColor,
    this.shadows,
    this.borderRadius,
    this.border,
    this.isHoverable = false,
    this.isSelected = false,
    this.selectedColor,
    this.selectedBorderColor,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    final effectiveColor = color ??
        (isSelected ? (selectedColor ?? cs.primaryContainer) : cs.surface);
    final effectiveShadows = isHoverable
        ? (isDark ? AppShadows.darkCardHover : AppShadows.cardHover)
        : (shadows ?? (isDark ? AppShadows.darkCard : AppShadows.card));
    final effectiveBorder = border ??
        (isSelected
            ? Border.all(color: selectedBorderColor ?? cs.primary, width: 2)
            : Border.all(color: cs.outlineVariant, width: 1));
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(InhaleRadius.cardRadius);
    final effectivePadding = padding ?? InhaleSpacing.cardPaddingInsets;
    final effectiveMargin = margin ?? EdgeInsets.zero;

    Widget card = AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeOutCubic,
      margin: effectiveMargin,
      decoration: BoxDecoration(
        color: effectiveColor,
        borderRadius: effectiveBorderRadius,
        border: effectiveBorder,
        boxShadow: effectiveShadows,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: Padding(padding: effectivePadding, child: child),
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveBorderRadius,
          splashColor: cs.primary.withValues(alpha: 0.08),
          highlightColor: cs.primary.withValues(alpha: 0.04),
          child: card,
        ),
      );
    }

    return card;
  }
}

// ============================================================================
// APP SURFACE (Elevated Card)
// ============================================================================

class AppSurface extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final int elevation;
  final BorderRadius? borderRadius;
  final Border? border;

  const AppSurface({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation = 1,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    List<BoxShadow> shadows;
    switch (elevation) {
      case 0:
        shadows = [];
        break;
      case 1:
        shadows = isDark ? AppShadows.darkLevel1 : AppShadows.level1;
        break;
      case 2:
        shadows = isDark ? AppShadows.darkLevel2 : AppShadows.level2;
        break;
      case 3:
        shadows = isDark ? AppShadows.darkLevel3 : AppShadows.level3;
        break;
      case 4:
        shadows = isDark ? AppShadows.darkLevel4 : AppShadows.level4;
        break;
      case 5:
        shadows = isDark ? AppShadows.darkLevel5 : AppShadows.level5;
        break;
      default:
        shadows = isDark ? AppShadows.darkLevel2 : AppShadows.level2;
    }

    return Container(
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? InhaleSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: color ?? cs.surface,
        borderRadius:
            borderRadius ?? BorderRadius.circular(InhaleRadius.cardRadius),
        border: border ?? Border.all(color: cs.outlineVariant, width: 1),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}

// ============================================================================
// APP TEXT FIELD
// ============================================================================

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final int? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final bool isDense;
  final bool expands;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final StrutStyle? strutStyle;
  final TextAlignVertical? textAlignVertical;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final bool showCounter;
  final Widget? counter;
  final String? counterText;
  final bool autofillHints;
  final Iterable<String>? autofillHintsList;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.inputFormatters,
    this.focusNode,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.isDense = false,
    this.expands = false,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.strutStyle,
    this.textAlignVertical,
    this.scrollPhysics,
    this.scrollController,
    this.showCounter = false,
    this.counter,
    this.counterText,
    this.autofillHints = false,
    this.autofillHintsList,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(InhaleRadius.inputRadius);
    final effectiveFillColor = widget.fillColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);
    final effectiveContentPadding =
        widget.contentPadding ?? InhaleSpacing.inputPaddingInsets;

    InputBorder border(Color color, double width) {
      return OutlineInputBorder(
        borderRadius: effectiveBorderRadius,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return Focus(
      onFocusChange: (hasFocus) => setState(() => _hasFocus = hasFocus),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        obscureText: widget.obscureText,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement != null
            ? MaxLengthEnforcement.values[widget.maxLengthEnforcement!]
            : null,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onSubmitted: widget.onSubmitted,
        inputFormatters: widget.inputFormatters,
        expands: widget.expands,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        strutStyle: widget.strutStyle,
        textAlignVertical: widget.textAlignVertical,
        scrollPhysics: widget.scrollPhysics,
        scrollController: widget.scrollController,
        autofillHints: widget.autofillHints ? widget.autofillHintsList : null,
        style: AppTypography.bodyLarge.copyWith(color: cs.onSurface),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          prefix: widget.prefix,
          suffix: widget.suffix,
          counterText: widget.showCounter ? widget.counterText : null,
          counter: widget.counter,
          filled: true,
          fillColor: effectiveFillColor,
          contentPadding: effectiveContentPadding,
          isDense: widget.isDense,
          labelStyle: AppTypography.bodyMedium.copyWith(
            color: cs.onSurfaceVariant,
          ),
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: cs.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          floatingLabelStyle: AppTypography.bodySmall.copyWith(
            color: _hasFocus ? cs.primary : cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: AppTypography.bodySmall.copyWith(color: cs.error),
          helperStyle: AppTypography.bodySmall.copyWith(
            color: cs.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          counterStyle: AppTypography.bodySmall.copyWith(
            color: cs.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          prefixIconColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.focused)) return cs.primary;
            return cs.onSurfaceVariant.withValues(alpha: 0.5);
          }),
          suffixIconColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.focused)) return cs.primary;
            return cs.onSurfaceVariant.withValues(alpha: 0.5);
          }),
          border: border(cs.outline, 1),
          enabledBorder: border(cs.outline, 1),
          focusedBorder: border(cs.primary, 2),
          errorBorder: border(cs.error, 1),
          focusedErrorBorder: border(cs.error, 2),
          disabledBorder: border(cs.outlineVariant, 1),
        ),
      ),
    );
  }
}

// ============================================================================
// APP SEARCH FIELD
// ============================================================================

class AppSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool autofocus;
  final bool enabled;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;

  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.onClear,
    this.leadingIcon,
    this.trailingIcon,
    this.autofocus = false,
    this.enabled = true,
    this.focusNode,
    this.padding,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final effectiveLeading = widget.leadingIcon ??
        Icon(
          Icons.search_rounded,
          size: 20,
          color: _hasFocus
              ? cs.primary
              : cs.onSurfaceVariant.withValues(alpha: 0.5),
        );

    Widget trailing = widget.trailingIcon ??
        (_controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.clear_rounded,
                  size: 20,
                  color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                onPressed: widget.enabled ? _clear : null,
                tooltip: 'Clear',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            : const SizedBox.shrink());

    return Semantics(
      textField: true,
      label: widget.hint ?? 'Search',
      child: Container(
        padding:
            widget.padding ?? EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
        decoration: BoxDecoration(
          color: _hasFocus
              ? cs.surface
              : cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(InhaleRadius.inputRadius),
          border: Border.all(
            color: _hasFocus ? cs.primary : cs.outlineVariant,
            width: _hasFocus ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            effectiveLeading,
            SizedBox(width: InhaleSpacing.sm),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: widget.autofocus,
                enabled: widget.enabled,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                onSubmitted: widget.onSubmitted,
                style: AppTypography.bodyMedium.copyWith(color: cs.onSurface),
                decoration: InputDecoration(
                  hintText: widget.hint ?? 'Search...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: InhaleSpacing.sm),
                ),
              ),
            ),
            if (_controller.text.isNotEmpty) ...[
              SizedBox(width: InhaleSpacing.xs),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// APP TEXTAREA (Multi-line text field)
// ============================================================================

class AppTextArea extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;

  const AppTextArea({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.minLines = 4,
    this.maxLines = 8,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      helperText: helperText,
      errorText: errorText,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      contentPadding: padding ?? InhaleSpacing.inputPaddingInsets,
    );
  }
}
