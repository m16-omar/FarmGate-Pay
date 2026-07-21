// This is a basic Flutter widget test for FarmGatePayApp.

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FarmGatePayApp());

    // Verify that the first page shows the 'Log Harvest Delivery' title
    expect(find.text('Log Harvest Delivery'), findsOneWidget);
  });
}
