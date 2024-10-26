// lib/theme/custom_button_style.dart

import 'package:flutter/material.dart';
import 'package:dycare/theme/app_colors.dart';

class CustomButtonStyle {
  static final ButtonStyle primaryElevated = ElevatedButton.styleFrom(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.primary,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle primaryElevatedDark = ElevatedButton.styleFrom(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.primaryDark,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle primaryOutlined = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: BorderSide(color: AppColors.primary),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle primaryOutlinedDark = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryDark,
    side: BorderSide(color: AppColors.primaryDark),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle primaryText = TextButton.styleFrom(
    foregroundColor: AppColors.primary,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle primaryTextDark = TextButton.styleFrom(
    foregroundColor: AppColors.primaryDark,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle secondaryElevated = ElevatedButton.styleFrom(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.secondary,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle secondaryOutlined = OutlinedButton.styleFrom(
    foregroundColor: AppColors.secondary,
    side: BorderSide(color: AppColors.secondary),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static final ButtonStyle secondaryText = TextButton.styleFrom(
    foregroundColor: AppColors.secondary,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
}