import 'package:flutter_test/flutter_test.dart';
import 'package:mygame/main.dart'; // Make sure this path is correct

void main() {
  testWidgets('SecureNotesApp launches and shows Welcome screen', (
    WidgetTester tester,
  ) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(const SecureNotesApp());

    // Verify that the Welcome screen appears
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Your thoughts, secured with trust.'), findsOneWidget);

    // Verify the Sign in / Sign up buttons are present
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);

    // Optional: Tap "Sign in" and verify navigation (modal appears)
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle(); // Wait for animation

    expect(find.text('Welcome Back!'), findsOneWidget);

    // Tap outside to close modal
    await tester.tapAt(const Offset(10, 10)); // Tap top-left (outside modal)
    await tester.pumpAndSettle();

    // Should be back to Welcome
    expect(find.text('Welcome!'), findsOneWidget);
  });

  testWidgets('Can open Sign up from Welcome', (WidgetTester tester) async {
    await tester.pumpWidget(const SecureNotesApp());

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
  });
}
