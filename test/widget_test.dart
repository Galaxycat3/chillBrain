import 'package:flutter_test/flutter_test.dart';
import 'package:mindfulnessstressreduction/main.dart';

void main() {
  testWidgets('home loads', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Chill Brain'), findsOneWidget);
    expect(find.text('Daily Affirmation'), findsOneWidget);
  });
}
