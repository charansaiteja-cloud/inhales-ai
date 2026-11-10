import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassSidebar extends StatelessWidget {
  final List<SidebarItem> items;
  final int currentIndex;
  final Function(int, String) onItemTap;
  final VoidCallback? onTap;

  const GlassSidebar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onItemTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: 260,
          decoration: BoxDecoration(
            color:
                isDark
                    ? InhaleColors.glassSurfaceHeavy
                    : InhaleColors.lightGlassSurfaceMedium,
            border: Border(
              right: BorderSide(
                color:
                    isDark
                        ? InhaleColors.glassBorder
                        : InhaleColors.lightGlassBorder,
                width: 0.5,
              ),
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Text(
                  'InhaleSkill AI',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color:
                        isDark
                            ? InhaleColors.blue
                            : InhaleColors.lightPrimaryBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  final isActive = index == currentIndex;
                  return TapRegion(
                    onTapInside: (_) => onItemTap(index, item.label),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? (isDark
                                    ? InhaleColors.blue.withValues(alpha: 0.15)
                                    : InhaleColors.blue.withValues(alpha: 0.1))
                                : Colors.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(InhaleRadius.md),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color:
                                isActive
                                    ? (isDark
                                        ? InhaleColors.blue
                                        : InhaleColors.lightPrimaryBlue)
                                    : (isDark
                                        ? InhaleColors.textSecondary
                                        : InhaleColors.lightTextSecondary),
                            size: 22,
                          ),
                          const SizedBox(width: 14),
                          Text(
                            item.label,
                            style: TextStyle(
                              color:
                                  isActive
                                      ? (isDark
                                          ? InhaleColors.blue
                                          : InhaleColors.lightPrimaryBlue)
                                      : (isDark
                                          ? InhaleColors.textPrimary
                                          : InhaleColors.lightNavyText),
                              fontWeight:
                                  isActive ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SidebarItem {
  final String label;
  final IconData icon;
  final String route;

  const SidebarItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
