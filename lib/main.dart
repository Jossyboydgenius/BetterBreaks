import 'dart:async';

import 'package:appearance/appearance.dart';
import 'package:better_breaks/ui/views/onboarding/splash_screen_view.dart';
import 'package:better_breaks/ui/views/setup/setup_view.dart';
import 'package:better_breaks/ui/views/dashboard/dashboard_view.dart';
import 'package:better_breaks/ui/views/planner/planner_view.dart';
import 'package:better_breaks/ui/views/experience/experience_view.dart';
import 'package:better_breaks/ui/views/analytics/analytics_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:better_breaks/app/flavor_config.dart';
import 'package:better_breaks/app/locator.dart';
import 'package:better_breaks/app/routes/navigation_service.dart';
import 'package:better_breaks/app/routes/app_routes.dart';
import 'package:better_breaks/app/themes.dart';
import 'package:better_breaks/app/theme_handler.dart';
import 'package:better_breaks/app/shared_preferences_manager.dart';
import 'package:better_breaks/data/services/connection_status.dart';
import 'package:better_breaks/data/services/in_activity_detector.dart';
import 'package:better_breaks/shared/app_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize SharedPreferences for the appearance package
  await AppPreferenceManager.instance.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setUpLocator(AppFlavorConfig(
    name: 'BetterBreaks',
    apiBaseUrl: dotenv.env['BASE_URL_PROD']!,
    webUrl: dotenv.env['WEB_URL_PROD']!,
    sentryDsn: dotenv.env['SENTRY_DSN'] ?? '',
    mixpanelToken: dotenv.env['MIXPANEL_TOKEN_PROD'] ?? '',
  ));

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    AppDimension.init(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return AppThemeHandler(
          child: Builder(builder: (context) {
            return MaterialApp(
              title: 'BetterBreaks',
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.initialRoute,
              routes: AppRoutes.routes,
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return MaterialPageRoute(
                    builder: (context) =>
                        const SetupView(), // Or whatever view you want as root
                  );
                }
                // Add routing for bottom navigation views
                else if (settings.name == '/dashboard') {
                  return MaterialPageRoute(
                    builder: (context) => const DashboardView(),
                  );
                } else if (settings.name == '/planner') {
                  return MaterialPageRoute(
                    builder: (context) => const PlannerView(),
                  );
                } else if (settings.name == '/experience') {
                  return MaterialPageRoute(
                    builder: (context) => const ExperienceView(),
                  );
                } else if (settings.name == '/analytics') {
                  return MaterialPageRoute(
                    builder: (context) => const AnalyticsView(),
                  );
                }
                return null;
              },
              onUnknownRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) =>
                      const SplashScreenView(), // Fallback route
                );
              },
              themeMode: Appearance.of(context)?.mode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              builder: (context, child) {
                return ConnectionWidget(
                  dismissOfflineBanner: false,
                  builder: (BuildContext context, bool isOnline) {
                    return InActivityDetector(
                      child: BotToastInit()(context, child),
                    );
                  },
                );
              },
              navigatorObservers: [BotToastNavigatorObserver()],
            );
          }),
        );

        // When you're ready to add BLoC providers, you can uncomment this code:
        /*
        return MultiBlocProvider(
          providers: [
            // Add at least one BlocProvider here
            BlocProvider<AppBloc>(create: (context) => AppBloc()),
          ],
          child: MaterialApp(
            title: 'BetterBreaks',
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.initialRoute,
            routes: AppRoutes.routes,
            theme: AppTheme.lightTheme,
            builder: (context, child) {
              return ConnectionWidget(
                dismissOfflineBanner: false,
                builder: (BuildContext context, bool isOnline) {
                  return InActivityDetector(
                    child: BotToastInit()(context, child),
                  );
                },
              );
            },
            navigatorObservers: [BotToastNavigatorObserver()],
          ),
        );
        */
      },
    );
  }
}
