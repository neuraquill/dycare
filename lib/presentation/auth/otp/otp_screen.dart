import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/otp/controller/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:dycare/theme/app_colors.dart';

class OtpScreen extends GetWidget<OtpController> {
  const OtpScreen({super.key});

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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Image section
            Expanded(
              flex: 50,
              child: Container(
                width: double.infinity,
                color: AppColors.secondaryLight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textPrimary,
                        size: screenHeight * 0.024,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'images/otp_image.png', // Adjust the path to your local image
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // OTP form
            Expanded(
              flex: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalSpacing * 2,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: fontSizes.xlarge,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: verticalSpacing),
                      Text(
                        'Enter 4 digit verification code sent to your registered mobile number.',
                        style: TextStyle(
                          fontSize: fontSizes.small,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 2),

                      // OTP Input Fields
                      PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        mainAxisAlignment: MainAxisAlignment.start,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          fieldHeight: 56,
                          fieldWidth: 56,
                          activeFillColor: AppColors.inputFill,
                          inactiveFillColor: AppColors.inputFill,
                          selectedFillColor: AppColors.inputFill,
                          activeColor: AppColors.inputBorder,
                          inactiveColor: AppColors.inputBorder,
                          selectedColor: AppColors.primary,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: AppColors.transparent,
                        enableActiveFill: true,
                        controller: controller.otpController,
                        onCompleted: (v) => controller.verifyOtp(),
                        onChanged: (value) {
                          // Handle changes if needed
                        },
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        beforeTextPaste: (text) => true,
                      ),
                      SizedBox(height: verticalSpacing * 2),

                      // Resend Timer/Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => controller.isResendActive.value
                              ? GestureDetector(
                                  onTap: controller.resendOtp,
                                  child: Text(
                                    'Resend Code',
                                    style: TextStyle(
                                      fontSize: fontSizes.small,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend code in ${controller.timerText}',
                                  style: TextStyle(
                                    fontSize: fontSizes.small,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 2),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                          ),
                          onPressed: controller.verifyOtp,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: fontSizes.medium,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      // Add some bottom padding for better scrolling
                      SizedBox(height: verticalSpacing * 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
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