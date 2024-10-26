// lib/widgets/custom_button.dart

import 'package:dycare/theme/custom_text_style.dart' as theme_style;
import 'package:flutter/material.dart';
import 'package:dycare/core/utils/app_export.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final bool isLoading;
  final double? width;
  final double height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.style,
    this.isLoading = false,
    this.width,
    this.height = 50,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: style ?? CustomButtonStyle.primaryElevated,
        onPressed: isLoading ? null : onPressed,
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          SizedBox(width: 8),
        ],
        Text(
          text,
          style: textStyle ?? theme_style.CustomTextStyle.buttonText(),
        ),
        if (suffixIcon != null) ...[
          SizedBox(width: 8),
          suffixIcon!,
        ],
      ],
    );
  }
}

// You can add more custom button variants here
class PrimaryButton extends CustomButton {
  PrimaryButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
    double height = 50,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) : super(
          key: key,
          text: text,
          onPressed: onPressed,
          style: CustomButtonStyle.primaryElevated,
          isLoading: isLoading,
          width: width,
          height: height,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
}

class SecondaryButton extends CustomButton {
  SecondaryButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
    double height = 50,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) : super(
          key: key,
          text: text,
          onPressed: onPressed,
          style: CustomButtonStyle.secondaryOutlined,
          isLoading: isLoading,
          width: width,
          height: height,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
}

class TextOnlyButton extends CustomButton {
  TextOnlyButton({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    double? width,
    double height = 50,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) : super(
          key: key,
          text: text,
          onPressed: onPressed,
          style: CustomButtonStyle.primaryText,
          isLoading: isLoading,
          width: width,
          height: height,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        );
}