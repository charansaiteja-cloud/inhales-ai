import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassSearchBar extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;

  const GlassSearchBar({
    super.key,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.enabled = true,
  });

  @override
  State<GlassSearchBar> createState() => _GlassSearchBarState();
}

class _GlassSearchBarState extends State<GlassSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.pill)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: InhaleColors.glassSurface,
              borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.pill)),
              border: Border.all(color: InhaleColors.glassBorderSubtle, width: 0.5),
            ),
            child: TextField(
              controller: _controller,
              enabled: widget.enabled,
              onTap: widget.onTap,
              onChanged: widget.onChanged,
              style: const TextStyle(color: InhaleColors.navyText, fontSize: 15),
              decoration: const BoxDecoration(),
              cursorColor: InhaleColors.primaryBlue,
            ),
          ),
        ),
      ),
    );
  }
}