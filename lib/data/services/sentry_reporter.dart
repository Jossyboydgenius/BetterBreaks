import 'package:flutter/material.dart';

/// A basic error reporter that logs exceptions to the console
/// This class replaces the Sentry implementation with a lightweight alternative
/// that doesn't require external dependencies
class SentryReporter {
  /// Setup method - doesn't do anything special now, but kept for API compatibility
  Future<void> setup(Widget app) async {
    // Simply run the app without any error reporting setup
    runApp(app);
  }
  
  /// Logs exceptions to the console
  Future<void> captureException(dynamic exception, {dynamic stackTrace}) async {
    // Simply log the exception and stack trace to console
    debugPrint('------------------------');
    debugPrint('❌ EXCEPTION CAPTURED:');
    debugPrint('$exception');
    
    if (stackTrace != null) {
      debugPrint('STACK TRACE:');
      debugPrint('$stackTrace');
    }
    debugPrint('------------------------');
  }
  
  /// Logs a message to the console
  Future<void> captureMessage(String message, {String? category}) async {
    debugPrint('------------------------');
    debugPrint('📝 ${category != null ? "[$category]" : ""} $message');
    debugPrint('------------------------');
  }
} 
