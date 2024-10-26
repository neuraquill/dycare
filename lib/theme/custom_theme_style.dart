// lib/theme/custom_text_style.dart

import 'package:flutter/material.dart';
import 'package:dycare/theme/app_colors.dart';

class CustomTextStyle {
  static TextStyle displayLarge({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    );
  }

  static TextStyle displayMedium({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle displaySmall({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle headlineLarge({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle headlineMedium({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle headlineSmall({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle titleLarge({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle titleMedium({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    );
  }

  static TextStyle titleSmall({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle bodyLarge({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    );
  }

  static TextStyle labelLarge({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    );
  }

  static TextStyle labelMedium({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    );
  }

  static TextStyle labelSmall({Color color = AppColors.textPrimary}) {
    return TextStyle(
      color: color,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
);
}
}