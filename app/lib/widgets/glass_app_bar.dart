import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  const GlassAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? InhaleColors.glassBorderSubtle
                  : InhaleColors.lightGlassBorderSubtle,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (leading != null)
              leading!
            else
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            Text(
              title,
              style: TextStyle(
                color: isDark
                    ? InhaleColors.textPrimary
                    : InhaleColors.lightNavyText,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
