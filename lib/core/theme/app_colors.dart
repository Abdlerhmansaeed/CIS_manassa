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

  // The Modern Archivist (Dark Theme)
  static const Color darkPrimary = Color(0xFFE02020); // The Pulse
  static const Color darkPrimaryLight = Color(0xFFFFB4AA); // For gradients
  static const Color darkPrimaryContainer = Color(0xFFE02020);
  static const Color darkOnPrimaryContainer = Color(0xFFFFF8F7);

  static const Color darkSurface = Color(0xFF1B110A); // The Foundation
  static const Color darkOnSurface = Color(0xFFF3DFD2); // The Ink
  static const Color darkOnSurfaceVariant = Color(0xFFE7BDB7); // Body text

  static const Color darkSecondary = Color(0xFFD6C4AA); // The Vellum
  static const Color darkTertiaryContainer = Color(0xFF846E64);

  static const Color darkSurfaceContainerLowest = Color(
    0xFF1C1008,
  ); // Input Fields Container/Recessed
  static const Color darkSurfaceContainerLow = Color(
    0xff000000,
  ); // Background Sections
  static const Color darkSurfaceContainer = Color(0xFF281D15);
  static const Color darkSurfaceContainerHigh = Color(
    0xFF33281F,
  ); // Interactive Cards
  static const Color darkSurfaceContainerHighest = Color(
    0xFF42372E,
  ); // Lifted (assuming value, to fit gradient)

  static const Color darkOutlineVariant = Color(0xFF4A3828); // Input Border
  static const Color darkOutlineVariantAlt = Color(0xFF5D3F3C); // Ghost Border

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
