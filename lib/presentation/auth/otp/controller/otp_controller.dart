// lib/presentation/auth/otp/controller/otp_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'dart:async';

class OtpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController otpController = TextEditingController();

  final RxBool isResendActive = false.obs;
  final RxInt resendCountdown = 30.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  void startResendTimer() {
    isResendActive.value = false;
    resendCountdown.value = 30;
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        isResendActive.value = true;
        timer.cancel();
      }
    });
  }

  void verifyOtp() async {
    if (otpController.text.length == 6) {
      try {
        // In a real app, you would call an API to verify the OTP
        // For now, we'll just simulate a successful verification
        await Future.delayed(Duration(seconds: 2));
        Get.snackbar(
          'Success',
          'OTP verified successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to verify OTP. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resendOtp() async {
    try {
      // In a real app, you would call an API to resend the OTP
      // For now, we'll just simulate a successful resend
      await Future.delayed(Duration(seconds: 1));
      Get.snackbar(
        'Success',
        'OTP resent successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      startResendTimer();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }
}