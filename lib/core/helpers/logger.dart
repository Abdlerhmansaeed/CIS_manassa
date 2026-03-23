import 'package:flutter/foundation.dart';

/// A unified logger class for the application.
/// Strictly used instead of print/debugPrint in production.
class Logger {
  static void info(String message) {
    if (kDebugMode) {
      _log('INFO', message);
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      _log('WARNING', message);
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _log('ERROR', '$message ${error ?? ''} ${stackTrace ?? ''}');
    }
    // In production, we would send this to Sentry/Firebase Crashlytics here.
  }

  static void debug(String message) {
    if (kDebugMode) {
      _log('DEBUG', message);
    }
  }

  static void _log(String level, String message) {
    final time = DateTime.now().toIso8601String();
    // Using debugPrint only in internal _log which is wrapped by kDebugMode guards
    debugPrint('[$time] [$level] $message');
  }
}
