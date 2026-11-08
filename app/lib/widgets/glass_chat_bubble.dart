import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String? timestamp;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isStreaming;
  final bool isLast;

  const GlassChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    this.timestamp,
    this.onTap,
    this.onLongPress,
    this.isStreaming = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(InhaleRadius.md),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUser
                      ? InhaleColors.primaryBlue.withValues(alpha: 0.85)
                      : InhaleColors.glassSurface,
                  border: Border.all(
                    color: isUser ? Colors.transparent : InhaleColors.glassBorderSubtle,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: isUser ? InhaleColors.pureWhite : InhaleColors.navyText,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    if (timestamp != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        timestamp!,
                        style: TextStyle(
                          fontSize: 10,
                          color: isUser ? InhaleColors.pureWhite.withValues(alpha: 0.7) : InhaleColors.secondaryText,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}