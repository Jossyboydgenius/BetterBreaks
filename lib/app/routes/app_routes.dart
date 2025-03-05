import 'package:flutter/material.dart';
import 'package:better_breaks/ui/views/onboarding/onboarding_view.dart';
import 'package:better_breaks/ui/views/onboarding/splash_screen_view.dart';
import 'package:go_router/go_router.dart';
import 'package:better_breaks/ui/views/auth/sign_in_view.dart';
import 'package:better_breaks/ui/views/auth/sign_up_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  static const String onboardingView = '/onboardingView';
  static const String splashScreenView = '/splashScreenView';

  static const String initialRoute = splashScreenView;

  static Map<String, WidgetBuilder> routes = {
    splashScreenView: (context) => const SplashScreenView(),
    onboardingView: (context) => const OnboardingView(),
    signIn: (context) => const SignInView(),
    signUp: (context) => const SignUpView(),
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