// lib/features/auth/auth_provider.dart

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  StreamSubscription<AuthState>? _subscription;

  @override
  FutureOr<User?> build() {
    final client = ref.watch(supabaseClientProvider);
    
    // Listen to Supabase auth state changes and update state accordingly
    _subscription = client.auth.onAuthStateChange.listen((data) {
      state = AsyncValue.data(data.session?.user);
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return client.auth.currentSession?.user;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(response.user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(supabaseClientProvider);
      await client.auth.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
