import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassLoadingIndicator extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const GlassLoadingIndicator({
    super.key,
    this.size = 40,
    this.strokeWidth = 3,
    this.color,
  });

  @override
  State<GlassLoadingIndicator> createState() => _GlassLoadingIndicatorState();
}

class _GlassLoadingIndicatorState extends State<GlassLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: (widget.color ?? InhaleColors.blue).withValues(alpha: 0.2),
            width: widget.strokeWidth,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: widget.strokeWidth,
            height: widget.strokeWidth,
            decoration: BoxDecoration(
              color: widget.color ?? InhaleColors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
