// First, let's create the ResponsiveFontSizes and AuthTextField classes in separate files
import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
// lib/presentation/common/responsive_font_sizes.dart


// lib/presentation/common/auth_text_field.dart



class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final ResponsiveFontSizes fontSize;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const AuthTextField({
    required this.controller,
    required this.label,
    required this.fontSize,
    this.validator,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
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
      ),
    );
  }
}

// Now, let's update the login screen
// lib/presentation/auth/login/login_screen.dart



class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

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
                children: [
                  Container(
                    height: screenHeight * 0.55,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: screenHeight * 0.024,
                        ),
                        onPressed: () => Get.back(),
                      ),
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
                        SizedBox(height: verticalSpacing * 0.35),
                        
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: fontSizes.xlarge,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: verticalSpacing * 2.5),

                        AuthTextField(
                          controller: controller.phoneController,
                          label: 'Phone Number',
                          fontSize: fontSizes,
                          validator: controller.validatePhone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: verticalSpacing * 3),

                        Obx(() => SizedBox(
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
                            onPressed: controller.isLoading.value ? null : controller.sendOTP,
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      fontSize: fontSizes.medium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        )),
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