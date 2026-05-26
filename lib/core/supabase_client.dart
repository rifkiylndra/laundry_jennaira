// lib/core/supabase_client.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_client.g.dart';

/// Global getter for the Supabase client instance.
SupabaseClient get supabase => Supabase.instance.client;

/// Riverpod provider to access the Supabase client.
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  try {
    return supabase;
  } catch (e) {
    // Return a dummy client in test environments where Supabase is not initialized
    return SupabaseClient('https://placeholder.supabase.co', 'placeholder');
  }
}
