import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/app.dart';
import 'package:inhaleskill_ai/features/home/home_screen.dart';

void main() {
  testWidgets('App boots and shows dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: InhaleSkillApp()));
    await tester.pump(const Duration(milliseconds: 3000));

    expect(find.text('InhaleSkill AI'), findsOneWidget);
  });

  testWidgets('Dashboard tiles are rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: HomeScreen())),
    );
    await tester.pump();

    expect(find.text('AI Chat'), findsOneWidget);
    expect(find.text('School'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
  });
}
