import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:inhaleskill_ai/app.dart';

void main() {
  testWidgets('App boots and shows dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: InhaleSkillApp()),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.text('InhaleSkill AI'), findsOneWidget);
  });

  testWidgets('Dashboard tiles are rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: InhaleSkillApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI Chat'), findsOneWidget);
    expect(find.text('School'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
  });
}