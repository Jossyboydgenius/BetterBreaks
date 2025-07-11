import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:better_breaks/ui/views/profile/profile_settings_view.dart';
import 'package:better_breaks/ui/views/settings/settings_view.dart';
import 'package:better_breaks/ui/views/settings/theme_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:better_breaks/ui/views/onboarding/onboarding_view.dart';
import 'package:better_breaks/ui/views/onboarding/splash_screen_view.dart';
import 'package:go_router/go_router.dart';
import 'package:better_breaks/ui/views/auth/sign_in_view.dart';
import 'package:better_breaks/ui/views/auth/sign_up_view.dart';
import 'package:better_breaks/ui/views/auth/forgot_password_view.dart';
import 'package:better_breaks/ui/views/auth/otp_verification_view.dart';
import 'package:better_breaks/ui/views/auth/create_new_password_view.dart';
import 'package:better_breaks/ui/views/auth/password_success_view.dart';
import 'package:better_breaks/ui/views/setup/setup_view.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';

  static const String onboardingView = '/onboardingView';
  static const String splashScreenView = '/splashScreenView';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String createNewPassword = '/create-new-password';
  static const String passwordSuccess = '/password-success';
  static const String setupView = '/setup-view';
  static const String plannerView = '/planner-view';
  static const String dashboardView = '/dashboard-view';
  static const String analyticsView = '/analytics-view';
  static const String experienceView = '/experience-view';
  static const String profileSettingsView = '/profile-settings-view';
  static const String settingsView = '/settings-view';
  static const String themeSettingsView = '/theme-settings-view';

  static const String initialRoute = splashScreenView;

  static Map<String, WidgetBuilder> routes = {
    splashScreenView: (context) => const SplashScreenView(),
    onboardingView: (context) => const OnboardingView(),
    signIn: (context) => const SignInView(),
    signUp: (context) => const SignUpView(),
    forgotPassword: (context) => const ForgotPasswordView(),
    otpVerification: (context) => const OtpVerificationView(email: ''),
    createNewPassword: (context) => const CreateNewPasswordView(),
    passwordSuccess: (context) => const PasswordSuccessView(),
    setupView: (context) => const SetupView(),
    plannerView: (context) => const PlannerView(),
    dashboardView: (context) => const DashboardView(),
    analyticsView: (context) => const AnalyticsView(),
    experienceView: (context) => const ExperienceView(),
    profileSettingsView: (context) => const ProfileSettingsView(),
    settingsView: (context) => const SettingsView(),
    themeSettingsView: (context) => const ThemeSettingsView(),
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
