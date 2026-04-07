import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Stitch UI Colors
  static const Color primary = Color(0xFFA0000A);
  static const Color primaryContainer = Color(0xFFC8191A);
  static const Color primaryDark = Color(0xFF8B0000);
  static const Color primarySurface = Color(0xFFFFF5F5);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color amber = Color(0xFFFFC107);
  static const Color amberSurface = Color(0xFFFFFBF0);
  static const Color amberText = Color(0xFF795548);

  static const Color surface = Color(0xFFFFF8F2);
  static const Color onSurface = Color(0xFF1E1B15);
  static const Color onSurfaceVariant = Color(0xFF5C403C);

  static const Color surfaceContainerHighest = Color(0xFFE9E1D8);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFFBF2E8);
  static const Color surfaceContainer = Color(0xFFF5EDE3);

  static const Color outline = Color(0xFF916F6B);
  static const Color secondary = Color(0xFF6A5B51);
  static const Color secondaryContainer = Color(0xFFF0DCCF);

  // Semantic
  static const Color error = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFCDD2);

  // Fallbacks for dark theme if needed (keeping existing)
  static const Color darkPrimary = Color(0xFFE02020);
  static const Color darkSecondary = Color(0xFFA89880);
  static const Color darkTertiary = Color(0xFF382820);
  static const Color darkNeutral = Color(0xFF000000);

  // Course Header Defaults
  static const List<Color> courseHeaderColors = [
    Color(0xFFA0000A),
    Color(0xFF1976D2),
    Color(0xFF0097A7),
    Color(0xFF7B1FA2),
    Color(0xFFE65100),
    Color(0xFF2E7D32),
  ];
}
