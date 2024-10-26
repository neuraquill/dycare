// lib/theme/theme_helper.dart

import 'package:dycare/theme/custom_text_style.dart' as customThemeStyle;
import 'package:flutter/material.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/theme/custom_text_style.dart';
import 'package:dycare/theme/custom_button_style.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: customThemeStyle.CustomTextStyle.titleLarge(color: AppColors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: CustomTextStyle.displayLarge(),
      displayMedium: CustomTextStyle.displayMedium(),
      displaySmall: CustomTextStyle.displaySmall(),
      headlineLarge: CustomTextStyle.headlineLarge(),
      headlineMedium: CustomTextStyle.headlineMedium(),
      headlineSmall: CustomTextStyle.headlineSmall(),
      titleLarge: CustomTextStyle.titleLarge(),
      titleMedium: CustomTextStyle.titleMedium(),
      titleSmall: CustomTextStyle.titleSmall(),
      bodyLarge: CustomTextStyle.bodyLarge(),
      bodyMedium: CustomTextStyle.bodyMedium(),
      bodySmall: CustomTextStyle.bodySmall(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: CustomButtonStyle.primaryElevated,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: CustomButtonStyle.primaryOutlined,
    ),
    textButtonTheme: TextButtonThemeData(
      style: CustomButtonStyle.primaryText,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.inputFill,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.error),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: CustomTextStyle.titleLarge(color: AppColors.white),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      error: AppColors.errorDark,
    ),
    textTheme: TextTheme(
      displayLarge: CustomTextStyle.displayLarge(color: AppColors.white),
      displayMedium: CustomTextStyle.displayMedium(color: AppColors.white),
      displaySmall: CustomTextStyle.displaySmall(color: AppColors.white),
      headlineLarge: CustomTextStyle.headlineLarge(color: AppColors.white),
      headlineMedium: CustomTextStyle.headlineMedium(color: AppColors.white),
      headlineSmall: CustomTextStyle.headlineSmall(color: AppColors.white),
      titleLarge: CustomTextStyle.titleLarge(color: AppColors.white),
      titleMedium: CustomTextStyle.titleMedium(color: AppColors.white),
      titleSmall: CustomTextStyle.titleSmall(color: AppColors.white),
      bodyLarge: CustomTextStyle.bodyLarge(color: AppColors.white),
      bodyMedium: CustomTextStyle.bodyMedium(color: AppColors.white),
      bodySmall: CustomTextStyle.bodySmall(color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: CustomButtonStyle.primaryElevatedDark,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: CustomButtonStyle.primaryOutlinedDark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: CustomButtonStyle.primaryTextDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.inputFillDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorderDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.inputBorderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryDark),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.errorDark),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.errorDark),
      ),
    ),
  );
}