import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';

class GlassSidebar extends StatelessWidget {
  final List<BottomNavDestination> items;
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: 260,
          decoration: const BoxDecoration(
            color: Color(0x99FFFFFF),
            border: Border(right: BorderSide(color: Color(0x4DFFFFFF), width: 0.5)),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                const Text(
                  'InhaleSkill AI',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: InhaleColors.primaryBlue),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  final isActive = index == currentIndex;
                  return TapRegion(
                    onTap: () => onItemTap(index, item.label),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive ? InhaleColors.primaryBlue.withValues(alpha: 0.12) : Colors.transparent,
                        borderRadius: const BorderRadius.all(Radius.circular(InhaleRadius.md)),
                      ),
                      child: Row(
                        children: [
                          Icon(item.icon, color: isActive ? InhaleColors.primaryBlue : InhaleColors.secondaryText, size: 22),
                          const SizedBox(width: 14),
                          Text(
                            item.label,
                            style: TextStyle(
                              color: isActive ? InhaleColors.primaryBlue : InhaleColors.navyText,
                              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
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

class GlassSidebarItem {
  final String label;
  final IconsData icon;
  final String route;

  const GlassSidebarItem({required this.label, required this.icon, required this.route});
}