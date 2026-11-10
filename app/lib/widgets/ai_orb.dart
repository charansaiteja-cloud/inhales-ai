import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

/// Premium AI Orb animation with state-specific visuals.
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
    final isAnimating =
        widget.isActive ||
        widget.isListening ||
        widget.isProcessing ||
        widget.isSpeaking;
    if (isAnimating && !_controller.isAnimating) {
      setState(() {});
    } else if (!isAnimating && _controller.isAnimating) {
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
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.isListening || widget.isActive) ...[
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
                            InhaleColors.blue.withValues(alpha: 0.4),
                            InhaleColors.pink.withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
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
                      InhaleColors.skyBlue.withValues(alpha: 0.8),
                      InhaleColors.blue.withValues(alpha: 0.6),
                      InhaleColors.pink.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
              if (widget.isListening)
                Container(
                  width: widget.size * 0.7,
                  height: widget.size * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: InhaleColors.skyBlue.withValues(alpha: 0.6),
                      width: 2,
                    ),
                  ),
                ),
              if (widget.isProcessing)
                Container(
                  height: 24,
                  margin: const EdgeInsets.only(top: 12),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      InhaleColors.blue,
                    ),
                  ),
                ),
              if (widget.isSpeaking)
                Container(
                  height: widget.size * 0.18,
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => RepaintBoundary(
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            final height = 4 + 6 * _scaleAnimation.value;
                            return Container(
                              width: 3,
                              height: height,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 1.5,
                              ),
                              color: InhaleColors.textPrimary,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
