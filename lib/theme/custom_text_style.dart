import 'package:flutter/material.dart';
import 'package:dycare/theme/app_colors.dart';

class CustomTextStyle {
  // Display Styles
  static TextStyle displayLarge({Color? color}) {
    return TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle displayMedium({Color? color}) {
    return TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle displaySmall({Color? color}) {
    return TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Headline Styles
  static TextStyle headlineLarge({Color? color}) {
    return TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle headlineMedium({Color? color}) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle headlineSmall({Color? color}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Title Styles
  static TextStyle titleLarge({Color? color}) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600, // Slightly increased weight for emphasis
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle titleMedium({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle titleSmall({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Body Styles
  static TextStyle bodyLarge({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle bodyMedium({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle bodySmall({Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Label Styles
  static TextStyle labelLarge({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle labelMedium({Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle labelSmall({Color? color}) {
    return TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: color ?? AppColors.textPrimary,
    );
  }

  // Custom Styles for Specific Use Cases
  static TextStyle buttonText({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600, // Increased weight for buttons
      letterSpacing: 0.1,
      color: color ?? Colors.white,
    );
  }

  static TextStyle appBarTitle({Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: color ?? Colors.white,
    );
  }

  static TextStyle cardTitle({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle cardSubtitle({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textSecondary,
    );
  }

  static TextStyle inputLabel({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500, // Emphasized for labels
      color: color ?? AppColors.textSecondary,
    );
  }

  static TextStyle inputText({Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textPrimary,
    );
  }

  static TextStyle errorText({Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.error,
    );
  }

  // Subtitle Style (new addition based on design)
  static TextStyle subTitle({Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.textSecondary,
    );
  }
}
