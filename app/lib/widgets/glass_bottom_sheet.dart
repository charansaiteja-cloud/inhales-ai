import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassBottomSheet extends StatelessWidget {
  final Widget child;
  final String? title;

  const GlassBottomSheet({super.key, required this.child, this.title});

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
  }) async {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassBottomSheet(child: child, title: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(InhaleRadius.lg),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xCCFFFFFF),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(InhaleRadius.lg),
            ),
            border: Border(
              top: BorderSide(color: Color(0x99FFFFFF), width: 0.5),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) ...[
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: InhaleColors.navyText,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
