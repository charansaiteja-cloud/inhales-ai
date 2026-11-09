import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

/// Premium AI Orb animation for voice/thinking states.
class AIOrb extends StatefulWidget {
  final double size;
  final bool isActive;
  final bool isListening;
  final bool isProcessing;
  final bool isSpeaking;

  const AIOrb({
    super.key,
    this.size = 120,
    this.isActive = false,
    this.isListening = false,
    this.isProcessing = false,
    this.isSpeaking = false,
  });

  @override
  State<AIOrb> createState() => _AIOrbState();
}

class _AIOrbState extends State<AIOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.isActive ||
        widget.isListening ||
        widget.isProcessing ||
        widget.isSpeaking) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AIOrb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive ||
        widget.isListening ||
        widget.isProcessing ||
        widget.isSpeaking) {
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        InhaleColors.electricBlue.withValues(
                          alpha: 0.4 * _opacityAnimation.value,
                        ),
                        InhaleColors.violet.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            width: widget.size * 0.6,
            height: widget.size * 0.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  InhaleColors.softCyan.withValues(alpha: 0.8),
                  InhaleColors.electricBlue.withValues(alpha: 0.6),
                  InhaleColors.violet.withValues(alpha: 0.4),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: InhaleColors.electricBlue.withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
          if (widget.isListening)
            Container(
              width: widget.size * 0.7,
              height: widget.size * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: InhaleColors.softCyan.withValues(alpha: 0.6),
                  width: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
