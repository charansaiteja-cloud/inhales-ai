import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

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
    final navItems = _effectiveItems;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0x99FFFFFF),
            border: Border(top: BorderSide(color: Color(0x4DFFFFFF), width: 0.5)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final isActive = index == currentIndex;
                  return Expanded(
                    child: TapRegion(
                      onTap: () => onTap(index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isActive ? item.activeIcon ?? item.icon : item.icon,
                            color: isActive ? InhaleColors.primaryBlue : InhaleColors.secondaryText,
                            size: 24,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              color: isActive ? InhaleColors.primaryBlue : InhaleColors.secondaryText,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
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
  final IconsData icon;
  final IconsData? activeIcon;

  const GlassBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}