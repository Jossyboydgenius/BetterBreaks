import 'package:flutter/material.dart';
import 'package:better_breaks/ui/views/onboarding/onboarding_view.dart';
import 'package:better_breaks/ui/views/onboarding/splash_screen_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String projects = '/projects';
  static const String tasks = '/tasks';
  static const String wallet = '/wallet';
  static const String members = '/members';
  static const String comments = '/comments';
  static const String phoneNumber = '/phone-number';

  static const String onboardingView = '/onboardingView';
  static const String splashScreenView = '/splashScreenView';

  static const String initialRoute = splashScreenView;

  static Map<String, WidgetBuilder> routes = {
    splashScreenView: (context) => const SplashScreenView(),
    onboardingView: (context) => const OnboardingView(),
  };

  static GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      // Define your routes here
      // Example:
      // GoRoute(
      //   path: splash,
      //   builder: (context, state) => const SplashScreen(),
      // ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
} 