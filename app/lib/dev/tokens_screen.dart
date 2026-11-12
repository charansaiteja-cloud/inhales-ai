import 'package:flutter/material.dart';
import '../core/theme/inhale_colors.dart';
import '../core/theme/inhale_tokens.dart';
import '../widgets/glass_app_bar.dart';

class TokensPreviewScreen extends StatelessWidget {
  const TokensPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(title: 'Design Tokens Preview'),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Colors',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ColorChip(InhaleColors.blue, 'InhaleColors.blue'),
                      _ColorChip(InhaleColors.pink, 'InhaleColors.pink'),
                      _ColorChip(InhaleColors.black, 'InhaleColors.black'),
                      _ColorChip(
                          InhaleColors.lightPrimaryBlue, 'lightPrimaryBlue'),
                      _ColorChip(InhaleColors.lightSkyBlue, 'lightSkyBlue'),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Spacing',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _SpacingChip(InhaleSpacing.xs, 'xs'),
                      _SpacingChip(InhaleSpacing.sm, 'sm'),
                      _SpacingChip(InhaleSpacing.md, 'md'),
                      _SpacingChip(InhaleSpacing.lg, 'lg'),
                      _SpacingChip(InhaleSpacing.xl, 'xl'),
                      _SpacingChip(InhaleSpacing.xxl, 'xxl'),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Radius',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _RadiusChip(InhaleRadius.pill, 'pill'),
                      _RadiusChip(InhaleRadius.md, 'md'),
                      _RadiusChip(InhaleRadius.lg, 'lg'),
                      _RadiusChip(InhaleRadius.xl, 'xl'),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Shadows',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 16,
                    children: [
                      _ShadowBox(
                          shadow: const BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      )),
                      _ShadowBox(
                          shadow: const BoxShadow(
                        color: Color(0x14050505),
                        blurRadius: 24,
                        offset: Offset(0, 8),
                      )),
                      _ShadowBox(
                          shadow: const BoxShadow(
                        color: Color(0x1A050505),
                        blurRadius: 36,
                        offset: Offset(0, 16),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  final Color color;
  final String label;
  const _ColorChip(this.color, this.label);

  @override
  Widget build(BuildContext context) => Container(
        width: 60,
        height: 60,
        color: color,
        child: Center(
          child: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 10)),
        ),
      );
}

class _SpacingChip extends StatelessWidget {
  final double spacing;
  final String label;
  const _SpacingChip(this.spacing, this.label);

  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 8,
        color: Colors.red,
      );
}

class _RadiusChip extends StatelessWidget {
  final double radius;
  final String label;
  const _RadiusChip(this.radius, this.label);

  @override
  Widget build(BuildContext context) => Container(
        width: 50,
        height: 8,
        color: Colors.green,
      );
}

class _ShadowBox extends StatelessWidget {
  final BoxShadow shadow;
  const _ShadowBox({required this.shadow});

  @override
  Widget build(BuildContext context) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [shadow]),
      );
}
