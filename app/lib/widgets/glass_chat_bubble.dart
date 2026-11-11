import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String timestamp;
  final bool isStreaming;

  const GlassChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.isStreaming = false,
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
            Expanded(child: _bubble(context, isDark)),
          ] else ...[
            Expanded(child: _bubble(context, isDark)),
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(top: 4, left: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(InhaleRadius.xs),
                border: Border.all(color: Colors.white24, width: 0.5),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bubble(BuildContext context, bool isDark) {
    final effectiveContent =
        message.isEmpty && isStreaming
            ? _buildStreamingIndicator()
            : MarkdownBody(
              data: message,
              selectable: true,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightTextPrimary,
                  fontSize: 15,
                  height: 1.5,
                ),
                code: TextStyle(
                  color:
                      isDark
                          ? InhaleColors.blue
                          : InhaleColors.deepNavy,
                  backgroundColor:
                      isDark
                          ? InhaleColors.blue.withValues(alpha: 0.15)
                          : InhaleColors.blue.withValues(alpha: 0.08),
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
                codeblockPadding: EdgeInsets.all(12),
                codeblockDecoration: BoxDecoration(
                  color:
                      isDark
                          ? InhaleColors.blue.withValues(alpha: 0.12)
                          : InhaleColors.blue.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:
            isUser
                ? (isDark
                    ? InhaleColors.blue.withValues(alpha: 0.25)
                    : InhaleColors.blue.withValues(alpha: 0.15))
                : (isDark
                    ? InhaleColors.glassSurfaceMedium
                    : InhaleColors.lightGlassSurfaceMedium),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isUser ? 8 : 4),
          topRight: Radius.circular(isUser ? 4 : 8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        border: Border.all(
          color:
              isUser
                  ? InhaleColors.blue.withValues(alpha: 0.3)
                  : InhaleColors.glassBorderSubtle,
          width: 0.5,
        ),
      ),
      child: effectiveContent,
    );
  }

  Widget _buildStreamingIndicator() {
    return const SizedBox(
      height: 24,
      width: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StreamingDot(),
          _StreamingDot(delay: 150),
          _StreamingDot(delay: 300),
        ],
      ),
    );
  }
}

class _StreamingDot extends StatefulWidget {
  final int delay;
  const _StreamingDot({this.delay = 0});

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
              color: InhaleColors.blue.withValues(
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
