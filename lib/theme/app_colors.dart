import 'package:flutter/material.dart';

class AppColors {
  // Transparent Color
  static const Color transparent = Color(0x00000000);

  // Primary colors - Using the blue shade (7A87B8)
  static const Color primary = Color(0xFF7A87B8);
  static const Color primaryDark = Color(0xFF6A77A8); // Darker variant
  static const Color primaryLight = Color(0xFF8A97C8); // Lighter variant

  // Secondary colors - Using the mint green shade (B2D6CD)
  static const Color secondary = Color(0xFFB2D6CD);
  static const Color secondaryDark = Color(0xFFA2C6BD); // Darker variant
  static const Color secondaryLight = Color(0xFFC2E6DD); // Lighter variant

  // Background colors
  static const Color background = Color(0xFFFEFEFE); // Near white for background
  static const Color backgroundDark = Color(0xFFA695B7); // Using the purple shade

  // Calender Colors
  static const Color weekends = Color(0xFFEADADE); // Using the light pink shade

  // Text colors
  static const Color textPrimary = Color(0xFF4A4A4A); // Dark gray that matches the palette
  static const Color textSecondary = Color(0xFF7A87B8); // Using the blue shade
  static const Color textPrimaryDark = Color(0xFFFEFEFE); // Light text for dark backgrounds
  static const Color textSecondaryDark = Color(0xFFB2D6CD); // Using the mint shade

  // Error colors - Adapting to palette
  static const Color error = Color(0xFFA695B7); // Using purple shade
  static const Color errorDark = Color(0xFF8A7597); // Darker purple

  // Accent colors - Using the light pink (EADADE)
  static const Color accentPink = Color(0xFFEADADE);

  // Custom colors
  static const Color booked = Color(0xFFC8BAD3); // Using the medium purple shade

  // Success colors - Using mint shades
  static const Color success = Color(0xFFB2D6CD);
  static const Color successDark = Color(0xFFA2C6BD);

  // Warning colors - Using warmer variants of the palette
  static const Color warning = Color(0xFFA695B7);
  static const Color warningDark = Color(0xFF967587);

  // Other colors
  static const Color white = Color(0xFFFEFEFE);
  static const Color black = Color(0xFF4A4A4A); // Soft black that matches palette

  // Input colors
  static const Color inputFill = Color(0xFFFEFEFE);
  static const Color inputFillDark = Color(0xFFC8BAD3); // Medium purple shade
  static const Color inputBorder = Color(0xFFEADADE); // Light pink shade
  static const Color inputBorderDark = Color(0xFFA695B7); // Purple shade
}