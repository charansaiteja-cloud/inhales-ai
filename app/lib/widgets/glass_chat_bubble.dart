import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

/// Liquid Glass chat bubble with theme awareness.
class GlassChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String timestamp;
  final bool isStreaming;
  final bool isLast;

  const GlassChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.isStreaming = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(top: 4, right: 8),
              decoration: BoxDecoration(
                gradient: InhaleColors.gradientPrimary,
                borderRadius: BorderRadius.circular(InhaleRadius.xs),
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
            Flexible(child: _bubble(context, isDark)),
          ] else ...[
            Flexible(child: _bubble(context, isDark)),
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(top: 4, left: 8),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? InhaleColors.glassSurfaceHeavy
                        : InhaleColors.lightGlassSurfaceMedium,
                borderRadius: BorderRadius.circular(InhaleRadius.xs),
                border: Border.all(
                  color:
                      isDark
                          ? InhaleColors.glassBorderSubtle
                          : InhaleColors.lightGlassBorderSubtle,
                ),
              ),
              child: const Icon(Icons.person_rounded, size: 18),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context, bool isDark) {
    final content =
        message.isEmpty && isStreaming
            ? _buildStreamingIndicator()
            : Text(
              message,
              style: TextStyle(
                color:
                    isDark
                        ? InhaleColors.textOnGlass
                        : InhaleColors.lightTextPrimary,
                fontSize: 15,
                height: 1.5,
              ),
            );

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:
            isUser
                ? (isDark
                    ? InhaleColors.electricBlue.withValues(alpha: 0.25)
                    : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.15))
                : (isDark
                    ? InhaleColors.glassSurfaceMedium
                    : InhaleColors.lightGlassSurface),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isUser ? InhaleRadius.sm : 4),
          topRight: Radius.circular(isUser ? 4 : InhaleRadius.sm),
          bottomLeft: const Radius.circular(InhaleRadius.sm),
          bottomRight: const Radius.circular(InhaleRadius.sm),
        ),
        border: Border.all(
          color:
              isUser
                  ? (isDark
                      ? InhaleColors.electricBlue.withValues(alpha: 0.3)
                      : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.2))
                  : (isDark
                      ? InhaleColors.glassBorderSubtle
                      : InhaleColors.lightGlassBorderSubtle),
          width: 0.5,
        ),
        boxShadow:
            isUser && isDark
                ? [
                  BoxShadow(
                    color: InhaleColors.electricBlue.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
                : null,
      ),
      child: content,
    );
  }

  Widget _buildStreamingIndicator() {
    return const SizedBox(
      height: 24,
      width: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StreamingDot(delay: 0),
          _StreamingDot(delay: 150),
          _StreamingDot(delay: 300),
        ],
      ),
    );
  }
}

class _StreamingDot extends StatefulWidget {
  final int delay;
  const _StreamingDot({required this.delay});

  @override
  State<_StreamingDot> createState() => _StreamingDotState();
}

class _StreamingDotState extends State<_StreamingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: InhaleColors.electricBlue.withValues(
                alpha: 0.3 + _controller.value * 0.7,
              ),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
