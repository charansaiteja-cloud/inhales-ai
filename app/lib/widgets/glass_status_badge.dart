import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';

class GlassStatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const GlassStatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BottomNavDestination {
  final String label;
  final IconData icon;
  const BottomNavDestination({required this.label, required this.icon});
}
