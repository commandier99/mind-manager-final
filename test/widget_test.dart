// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:mind_manager/main.dart';

void main() {
  testWidgets('App builds and shows title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Build the PlaceholderScreen inside a MaterialApp so AppBar and Scaffold are available.
    await tester.pumpWidget(const MaterialApp(home: PlaceholderScreen()));
    await tester.pumpAndSettle();

    // Verify the app bar title is present.
    expect(find.text('Welcome to Mind-Manager!'), findsOneWidget);
  });
}
