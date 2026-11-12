import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:inhaleskill_ai/widgets/glass_button.dart';
import 'package:inhaleskill_ai/core/theme/inhale_theme.dart';
import 'package:inhaleskill_ai/core/theme/inhale_colors.dart';

void main() {
  testWidgets('GlassButton uses correct background in dark mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: InhaleTheme.dark,
        home: const Scaffold(
          body: GlassButton(label: 'Test', enabled: true),
        ),
      ),
    );
    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(GlassButton),
        matching: find.byType(Container),
      ),
    );
    final bg = container.decoration as BoxDecoration;
    expect(bg.color, equals(InhaleColors.blue));
  });
}