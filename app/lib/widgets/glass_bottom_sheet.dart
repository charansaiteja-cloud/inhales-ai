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
      builder: (ctx) => GlassBottomSheet(title: title, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(InhaleRadius.lg),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? InhaleColors.glassSurfaceHeavy
                : InhaleColors.lightGlassSurfaceMedium,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(InhaleRadius.lg),
            ),
            border: Border(
              top: BorderSide(
                color: isDark
                    ? InhaleColors.glassBorder
                    : InhaleColors.lightGlassBorder,
                width: 0.5,
              ),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
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
