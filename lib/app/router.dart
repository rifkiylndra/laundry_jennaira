// lib/app/router.dart

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:laundry_jennaira/features/auth/login_screen.dart';
import 'package:laundry_jennaira/features/auth/splash_screen.dart';
import 'package:laundry_jennaira/features/dashboard/dashboard_screen.dart';
import 'package:laundry_jennaira/features/order/order_list_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isAuthLoading = authState.isLoading;
      final profile = authState.valueOrNull;
      final isLoggedIn = profile != null;
      
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      if (isAuthLoading) {
        return null;
      }

      if (!isLoggedIn && !isGoingToLogin) {
        return '/login';
      }

      if (isLoggedIn) {
        if (isGoingToLogin || isGoingToSplash) {
          if (profile.role == 'admin') {
            return '/dashboard';
          } else {
            return '/orders';
          }
        }
        
        // Cashier role guards
        if (profile.role == 'cashier') {
          final restrictedRoutes = ['/dashboard', '/transactions', '/reports', '/settings'];
          if (restrictedRoutes.any((route) => state.matchedLocation.startsWith(route))) {
            return '/orders';
          }
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrderListScreen(),
      ),
    ],
  );
}
