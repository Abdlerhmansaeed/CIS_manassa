import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Stitch UI Colors
  static const Color primary = Color(0xFFA0000A);
  static const Color primaryContainer = Color(0xFFC8191A);
  static const Color onPrimary = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFFF8F2);
  static const Color onSurface = Color(0xFF1E1B15);
  static const Color onSurfaceVariant = Color(0xFF5C403C);

  static const Color surfaceContainerHighest = Color(0xFFE9E1D8);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainer = Color(0xFFF5EDE3);

  static const Color outline = Color(0xFF916F6B);
  static const Color secondary = Color(0xFF6A5B51);
  static const Color secondaryContainer = Color(0xFFF0DCCF);

  // Fallbacks for dark theme if needed (keeping existing)
  static const Color darkPrimary = Color(0xFFE02020);
  static const Color darkSecondary = Color(0xFFA89880);
  static const Color darkTertiary = Color(0xFF382820);
  static const Color darkNeutral = Color(0xFF000000);
}
