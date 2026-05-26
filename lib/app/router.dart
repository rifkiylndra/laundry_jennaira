// lib/app/router.dart

import 'package:go_router/go_router.dart';
import 'package:laundry_jennaira/features/auth/login_screen.dart';
import 'package:laundry_jennaira/features/auth/splash_screen.dart';
import 'package:laundry_jennaira/features/dashboard/dashboard_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/splash',
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
  ],
);
