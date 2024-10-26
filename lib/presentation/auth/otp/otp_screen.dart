// lib/presentation/auth/otp/otp_screen.dart

import 'package:dycare/theme/custom_theme_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/otp/controller/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends GetWidget<OtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Enter the 6-digit code sent to your email',
                style: CustomTextStyle.bodyLarge(),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.textSecondary,
                  selectedColor: AppColors.primary,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: false,
                controller: controller.otpController,
                onCompleted: (v) {
                  controller.verifyOtp();
                },
                onChanged: (value) {
                  // You can handle changes here if needed
                },
                beforeTextPaste: (text) {
                  // You can validate here if needed
                  return true;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: CustomButtonStyle.primaryElevated,
                onPressed: controller.verifyOtp,
                child: Text('Verify OTP'),
              ),
              SizedBox(height: 16),
              Obx(() => controller.isResendActive.value
                  ? TextButton(
                      onPressed: controller.resendOtp,
                      child: Text('Resend OTP'),
                    )
                  : Text(
                      'Resend OTP in ${controller.resendCountdown.value} seconds',
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.bodyMedium(
                          color: AppColors.textSecondary),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}