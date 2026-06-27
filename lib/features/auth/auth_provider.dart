// lib/features/auth/auth_provider.dart

import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laundry_jennaira/core/supabase_client.dart';
import 'package:laundry_jennaira/shared/models/profile_model.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  StreamSubscription<AuthState>? _subscription;

  @override
  FutureOr<ProfileModel?> build() async {
    final client = ref.watch(supabaseClientProvider);
    
    // Listen to Supabase auth state changes
    _subscription = client.auth.onAuthStateChange.listen((data) async {
      final user = data.session?.user;
      if (user != null) {
        try {
          final profileData = await client
              .from('profiles')
              .select()
              .eq('id', user.id)
              .single();
          state = AsyncValue.data(ProfileModel.fromJson(profileData));
        } catch (e, st) {
          state = AsyncValue.error(e, st);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    // Initial load
    final user = client.auth.currentSession?.user;
    if (user != null) {
      try {
        final profileData = await client
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        return ProfileModel.fromJson(profileData);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(supabaseClientProvider);
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      final user = response.user;
      if (user != null) {
        final profileData = await client
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        state = AsyncValue.data(ProfileModel.fromJson(profileData));
      }
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
  Future<void> updateProfile(String name) async {
    state = const AsyncValue.loading();
    try {
      final client = ref.read(supabaseClientProvider);
      final user = client.auth.currentUser;
      if (user == null) throw Exception('Sesi telah berakhir, silakan login kembali.');
      
      await client.from('profiles').update({'name': name}).eq('id', user.id);
      
      // Fetch updated profile
      final profileData = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      state = AsyncValue.data(ProfileModel.fromJson(profileData));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final client = ref.read(supabaseClientProvider);
      await client.auth.updateUser(UserAttributes(password: newPassword));
    } catch (e) {
      rethrow;
    }
  }
}
