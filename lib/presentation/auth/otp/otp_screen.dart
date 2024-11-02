import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/otp/controller/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top container for illustration
            Container(
              height: screenHeight * 0.45,
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
                vertical: verticalSpacing * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: fontSizes.xlarge,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: verticalSpacing),
                  Text(
                    'Enter 4 digit verification code sent to your registered mobile number.',
                    style: TextStyle(
                      fontSize: fontSizes.small,
                      color: Colors.grey[600],
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
                      activeFillColor: Colors.grey[200],
                      inactiveFillColor: Colors.grey[200],
                      selectedFillColor: Colors.grey[200],
                      activeColor: Colors.grey[300],
                      inactiveColor: Colors.grey[300],
                      selectedColor: Colors.grey[400],
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    controller: controller.otpController,
                    onCompleted: (v) => controller.verifyOtp(),
                    onChanged: (value) {
                      // Handle changes if needed
                    },
                    beforeTextPaste: (text) => true,
                  ),
                  SizedBox(height: verticalSpacing * 2),

                  // Resend Timer/Button

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() => controller.isResendActive.value
                        ? GestureDetector(
                            onTap: controller.resendOtp,
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: fontSizes.small,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        : Text(
                            'Resend code in ${controller.timerText}',
                            style: TextStyle(
                              fontSize: fontSizes.small,
                              color: Colors.grey[600],
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
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
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
                ],
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