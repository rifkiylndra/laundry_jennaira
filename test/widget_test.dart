// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:laundry_jennaira/main.dart';

class MockAuthNotifier extends Auth {
  @override
  FutureOr<User?> build() {
    return null;
  }

  @override
  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.data(null);
  }

  @override
  Future<void> signOut() async {
    state = const AsyncValue.data(null);
  }
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame with mocked authProvider.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => MockAuthNotifier()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that our app displays the correct placeholder text.
    expect(find.text('Laundry Jennaira'), findsOneWidget);

    // Pump timer duration to allow navigation and avoid pending timers
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
  });
}
