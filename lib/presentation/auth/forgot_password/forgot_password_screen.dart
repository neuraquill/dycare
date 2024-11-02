import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.06;
    final buttonHeight = screenHeight * 0.065;
    
    final fontSizes = ResponsiveFontSizes(
      tiny: screenHeight * 0.014,
      small: screenHeight * 0.016,
      medium: screenHeight * 0.018,
      large: screenHeight * 0.024,
      xlarge: screenHeight * 0.032,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top container for illustration
                  Container(
                    height: screenHeight * 0.5,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: screenHeight * 0.024,
                          ),
                          onPressed: () => Get.back(),
                        ),
                        
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot\nyour Password?',
                          style: TextStyle(
                            fontSize: fontSizes.xlarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.5,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: verticalSpacing * 1.5),
                        
                        Text(
                          'Please enter your mobile number to receive password reset instructions',
                          style: TextStyle(
                            fontSize: fontSizes.small,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: verticalSpacing * 2),

                        AuthTextField(
                          controller: controller.emailController,
                          label: 'Mobile Number',
                          fontSize: fontSizes,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (!GetUtils.isPhoneNumber(value)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: verticalSpacing * 3),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[800],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                            ),
                            onPressed: controller.resetPassword,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: fontSizes.medium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ResponsiveFontSizes fontSize;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const AuthTextField({
    required this.controller,
    required this.label,
    required this.fontSize,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: fontSize.medium,
        color: Colors.black87,
      ),
      cursorColor: Colors.black87,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: fontSize.small,
        ),
        floatingLabelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: fontSize.tiny,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
        ),
        contentPadding: const EdgeInsets.only(bottom: 8),
        isDense: true,
        filled: false,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class ResponsiveFontSizes {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double xlarge;

  ResponsiveFontSizes({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.xlarge,
  });
}