import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassTextField extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final double? width;
  final String? initialValue;
  final String? error;
  final bool enabled;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;

  const GlassTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.width,
    this.initialValue,
    this.error,
    this.enabled = true,
    this.controller,
    this.onSubmitted,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late final _controller = widget.controller ?? TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.md)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: widget.width,
            decoration: BoxDecoration(
              color: InhaleColors.glassSurface,
              borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.md)),
              border: Border.all(
                color: widget.error != null ? InhaleColors.error : InhaleColors.glassBorderSubtle,
                width: 0.5,
              ),
            ),
            child: TextField(
              controller: _controller,
              enabled: widget.enabled,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              style: const TextStyle(color: InhaleColors.navyText, fontSize: 15),
              cursorColor: InhaleColors.primaryBlue,
              decoration: const BoxDecoration(),
              onSubmitted: widget.onSubmitted,
            ),
          ),
        ),
      ),
    );
  }
}