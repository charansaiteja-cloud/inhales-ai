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
    final hintText = widget.hintText ?? 'Search';
    final effectiveOnTap = widget.onTap ?? (() {});

    return Semantics(
      label: hintText,
      onTap: effectiveOnTap,
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: effectiveOnTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(InhaleRadius.pill),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: InhaleColors.glassSurface,
                    borderRadius: BorderRadius.circular(InhaleRadius.pill),
                    border: Border.all(
                      color: InhaleColors.glassBorderSubtle,
                      width: 0.5,
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    enabled: widget.enabled,
                    onTap: () {},
                    onChanged: widget.onChanged,
                    style: const TextStyle(color: Colors.black87, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    cursorColor: InhaleColors.primaryBlue,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
