import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

/// Log severity levels in ascending order.
enum LogLevel { debug, info, warning, error }

/// A unified, structured logger.
///
/// Usage:
///   Logger.info('User signed in');
///   Logger.warning('Token expiring soon');
///   Logger.error('Fetch failed', error, stackTrace);
///
/// In release builds only [LogLevel.error] is forwarded to your crash reporter.
/// Set [Logger.minLevel] to filter noise during development.
class Logger {
  // ─── Configuration ────────────────────────────────────────────────────────

  /// Minimum level that gets printed in debug mode.
  /// Change to [LogLevel.warning] to silence debug/info during heavy testing.
  static LogLevel minLevel = LogLevel.debug;

  /// Replace this with your Sentry / Firebase Crashlytics call.
  static void Function(String message, Object error, StackTrace stackTrace)?
  onCrashReport;

  // ─── Public API ───────────────────────────────────────────────────────────

  static void debug(String message, [String? tag]) =>
      _log(LogLevel.debug, message, tag: tag);

  static void info(String message, [String? tag]) =>
      _log(LogLevel.info, message, tag: tag);

  static void warning(String message, [String? tag]) =>
      _log(LogLevel.warning, message, tag: tag);

  static void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  ]) => _log(
    LogLevel.error,
    message,
    error: error,
    stackTrace: stackTrace,
    tag: tag,
  );

  // ─── Internal ─────────────────────────────────────────────────────────────

  static void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    // Always forward errors to crash reporter (even in release).
    if (level == LogLevel.error && error != null && stackTrace != null) {
      onCrashReport?.call(message, error, stackTrace);
    }

    if (!kDebugMode) return;
    if (level.index < minLevel.index) return;

    final _Meta meta = _Meta.of(level);
    final String prefix = tag != null ? '[$tag] ' : '';
    final String time = _shortTime();

    final buffer = StringBuffer();
    buffer.writeln(
      '${meta.color}${meta.emoji} ${meta.label.padRight(7)} $time  $prefix$message$_reset',
    );

    if (error != null) {
      buffer.writeln('$_dimRed   ⤷ error     : $error$_reset');
    }
    if (stackTrace != null) {
      final trimmed = _trimStack(stackTrace);
      buffer.writeln('$_dimRed   ⤷ stacktrace:\n$trimmed$_reset');
    }

    dev.log(
      buffer.toString(),
      name: tag ?? meta.label,
      level: _dartLogLevel(level),
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }

  /// Keeps the first [maxLines] lines of a stack trace to reduce noise.
  static String _trimStack(StackTrace st, {int maxLines = 8}) {
    final lines = st.toString().trimRight().split('\n');
    final kept = lines.take(maxLines).join('\n');
    final extra = lines.length - maxLines;
    return extra > 0 ? '$kept\n   … $extra more lines' : kept;
  }

  static String _shortTime() {
    final t = DateTime.now();
    return '${_p(t.hour)}:${_p(t.minute)}:${_p(t.second)}.${t.millisecond.toString().padLeft(3, '0')}';
  }

  static String _p(int n) => n.toString().padLeft(2, '0');

  static int _dartLogLevel(LogLevel l) => switch (l) {
    LogLevel.debug => 500,
    LogLevel.info => 800,
    LogLevel.warning => 900,
    LogLevel.error => 1000,
  };

  // ANSI codes
  static const _reset = '\x1B[0m';
  static const _dimRed = '\x1B[2;31m';
}

// ─── Private meta helper ──────────────────────────────────────────────────────

class _Meta {
  const _Meta({required this.label, required this.emoji, required this.color});

  final String label;
  final String emoji;
  final String color;

  static _Meta of(LogLevel level) => switch (level) {
    LogLevel.debug => const _Meta(
      label: 'DEBUG',
      emoji: '🔍',
      color: '\x1B[37m',
    ), // white
    LogLevel.info => const _Meta(
      label: 'INFO',
      emoji: '💬',
      color: '\x1B[36m',
    ), // cyan
    LogLevel.warning => const _Meta(
      label: 'WARNING',
      emoji: '⚠️',
      color: '\x1B[33m',
    ), // yellow
    LogLevel.error => const _Meta(
      label: 'ERROR',
      emoji: '🔥',
      color: '\x1B[1;31m',
    ), // bold red
  };
}
