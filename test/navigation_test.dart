import 'package:flutter_test/flutter_test.dart';
import 'package:mindfulnessstressreduction/main.dart';

void main() {
  testWidgets('navigates to Affirmations', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Daily Affirmation'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Positive Affirmations'), findsOneWidget);
  });

  testWidgets('navigates to Reflection', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.scrollUntilVisible(find.text('Reflection'), 200.0);
    await tester.tap(find.text('Reflection'));
    await tester.pumpAndSettle();
    expect(find.text('Reflection'), findsWidgets);
    expect(
      find.textContaining('I understand that you will be graded individually'),
      findsOneWidget,
    );
  });
}

