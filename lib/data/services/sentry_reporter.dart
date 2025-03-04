import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:better_breaks/app/flavor_config.dart';
import 'package:better_breaks/app/locator.dart';

class SentryReporter {
  Future<void> setup(Widget app) async {
    final config = locator<AppFlavorConfig>();
    
    if (config.sentryDsn.isEmpty) {
      // If no Sentry DSN is provided, just run the app without Sentry
      runApp(app);
      return;
    }
    
    await SentryFlutter.init(
      (options) {
        options.dsn = config.sentryDsn;
        options.tracesSampleRate = 1.0; // Capture 100% of transactions
        options.environment = config.name;
        options.enableAutoSessionTracking = true;
      },
      appRunner: () => runApp(app),
    );
  }
  
  Future<void> captureException(dynamic exception, {dynamic stackTrace}) async {
    final config = locator<AppFlavorConfig>();
    
    if (config.sentryDsn.isEmpty) {
      // Just print the exception if Sentry is not configured
      debugPrint('Exception: $exception');
      debugPrint('StackTrace: $stackTrace');
      return;
    }
    
    await Sentry.captureException(exception, stackTrace: stackTrace);
  }
} 