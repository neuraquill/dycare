// lib/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'package:dycare/theme/custom_text_style.dart';

class AppTypography {
  // Main text styles
  static final TextStyle heading1 = CustomTextStyle.headlineLarge();
  static final TextStyle heading2 = CustomTextStyle.headlineMedium();
  static final TextStyle heading3 = CustomTextStyle.headlineSmall();
  static final TextStyle bodyLarge = CustomTextStyle.bodyLarge();
  static final TextStyle bodyMedium = CustomTextStyle.bodyMedium();
  static final TextStyle bodySmall = CustomTextStyle.bodySmall();
  static final TextStyle button = CustomTextStyle.buttonText();
  static final TextStyle appBarTitle = CustomTextStyle.appBarTitle();
  static final TextStyle cardTitle = CustomTextStyle.cardTitle();
  static final TextStyle cardSubtitle = CustomTextStyle.cardSubtitle();
  static final TextStyle inputLabel = CustomTextStyle.inputLabel();
  static final TextStyle inputText = CustomTextStyle.inputText();
  static final TextStyle errorText = CustomTextStyle.errorText();

  // Helper methods for common modifications
  static TextStyle withPrimaryColor(TextStyle style, Color primaryColor) {
    return style.copyWith(color: primaryColor);
  }

  static TextStyle withSecondaryColor(TextStyle style, Color secondaryColor) {
    return style.copyWith(color: secondaryColor);
  }

  static TextStyle withBold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle withItalic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }

  static TextStyle withSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  // Example combinations for quick use
  static TextStyle heading1PrimaryBold(Color primaryColor) {
    return heading1.copyWith(color: primaryColor, fontWeight: FontWeight.bold);
  }

  static TextStyle bodyLargeSecondary(Color secondaryColor) {
    return bodyLarge.copyWith(color: secondaryColor);
  }
}
