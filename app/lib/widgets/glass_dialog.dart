import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassDialog extends StatelessWidget {
  final String? title;
  final Widget? content;
  final List<Widget>? actions;

  const GlassDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => GlassDialog(title: title, content: content, actions: actions),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.lg)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xCCFFFFFF),
                border: Border.all(color: Color(0x99FFFFFF), width: 0.5),
              ),
              padding: const EdgeInsets.all(InhaleSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: InhaleColors.navyText)),
                    const SizedBox(height: 16),
                  ],
                  if (content != null) content!,
                  if (actions != null) ...[
                    const SizedBox(height: 24),
                    Row(
                     spacing: 12,
                      children: actions!,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}