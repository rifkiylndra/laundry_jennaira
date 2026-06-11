// lib/app/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:laundry_jennaira/features/auth/auth_provider.dart';
import 'package:laundry_jennaira/shared/models/profile_model.dart';
import 'package:laundry_jennaira/features/auth/login_screen.dart';
import 'package:laundry_jennaira/features/auth/splash_screen.dart';
import 'package:laundry_jennaira/features/dashboard/dashboard_screen.dart';
import 'package:laundry_jennaira/features/order/order_list_screen.dart';
import 'package:laundry_jennaira/features/transaction/transaction_list_screen.dart';
import 'package:laundry_jennaira/features/report/screens/monthly_report_screen.dart';
import 'package:laundry_jennaira/features/settings/screens/settings_screen.dart';
import 'package:laundry_jennaira/features/main/main_navigation_screen.dart';

part 'router.g.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen<AsyncValue<ProfileModel?>>(
      authProvider,
      (_, __) => notifyListeners(),
    );
  }
}

@riverpod
GoRouter router(RouterRef ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    refreshListenable: notifier,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(authProvider);

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
          final restrictedRoutes = [
            '/dashboard',
            '/transactions',
            '/reports',
            '/settings',
          ];
          if (restrictedRoutes.any(
            (route) => state.matchedLocation.startsWith(route),
          )) {
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
      ShellRoute(
        builder: (context, state, child) => MainNavigationScreen(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrderListScreen(),
          ),
          GoRoute(
            path: '/transactions',
            builder: (context, state) => const TransactionListScreen(),
          ),
          GoRoute(
            path: '/reports',
            builder: (context, state) => const MonthlyReportScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}
