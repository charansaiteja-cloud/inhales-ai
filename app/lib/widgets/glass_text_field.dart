import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Liquid Glass text field/input.
class GlassTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool autofocus;
  final double? blur;

  const GlassTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.blur,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBlur = widget.blur ?? InhaleBlur.light;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isDark
            ? InhaleColors.glassSurfaceLight
            : InhaleColors.lightGlassSurface,
        borderRadius: BorderRadius.circular(InhaleRadius.sm),
        border: Border.all(
          color: _focusNode.hasFocus
              ? (isDark ? InhaleColors.blue : InhaleColors.lightPrimaryBlue)
              : (isDark
                  ? InhaleColors.glassBorderSubtle
                  : InhaleColors.lightGlassBorderSubtle),
          width: _focusNode.hasFocus ? 1.5 : 0.5,
        ),
        boxShadow: _focusNode.hasFocus
            ? (isDark ? InhaleShadows.glassBlue : InhaleShadows.subtle)
            : (isDark ? InhaleShadows.subtle : null),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(InhaleRadius.sm),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveBlur,
            sigmaY: effectiveBlur,
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            style: TextStyle(
              color: isDark
                  ? InhaleColors.textPrimary
                  : InhaleColors.lightNavyText,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintStyle: TextStyle(
                color: isDark
                    ? InhaleColors.textMuted
                    : InhaleColors.lightTextSecondary,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
