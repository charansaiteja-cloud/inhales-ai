import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';

class GlassBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<GlassBottomNavItem> items;
  final List<GlassBottomNavItem>? destinations;

  const GlassBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.destinations,
  });

  List<GlassBottomNavItem> get _effectiveItems => destinations ?? items;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navItems = _effectiveItems;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? InhaleColors.glassSurfaceHeavy
                : InhaleColors.lightGlassSurfaceMedium,
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
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isActive = index == currentIndex;

                  return Expanded(
                    child: Semantics(
                      button: true,
                      label: item.label,
                      onTap: () => onTap(index),
                      child: TapRegion(
                        onTapInside: (_) => onTap(index),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isActive
                                  ? item.activeIcon ?? item.icon
                                  : item.icon,
                              color: isActive
                                  ? (isDark
                                      ? InhaleColors.blue
                                      : InhaleColors.lightPrimaryBlue)
                                  : (isDark
                                      ? InhaleColors.textMuted
                                      : InhaleColors.lightTextMuted),
                              size: 24,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 12,
                                color: isActive
                                    ? (isDark
                                        ? InhaleColors.blue
                                        : InhaleColors.lightPrimaryBlue)
                                    : (isDark
                                        ? InhaleColors.textMuted
                                        : InhaleColors.lightTextMuted),
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GlassBottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  const GlassBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}
