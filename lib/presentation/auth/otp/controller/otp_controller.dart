import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'dart:async';

class OtpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController otpController = TextEditingController();

  final RxBool isResendActive = false.obs;
  final RxString timerText = "".obs;
  Timer? _resendTimer;
  int _totalSeconds = 30; // Changed to 30 seconds

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  void startResendTimer() {
    isResendActive.value = false;
    _totalSeconds = 30;
    updateTimerText();
    
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalSeconds > 0) {
        _totalSeconds--;
        updateTimerText();
      } else {
        isResendActive.value = true;
        timer.cancel();
      }
    });
  }

  void updateTimerText() {
    String seconds = (_totalSeconds % 60).toString().padLeft(2, '0');
    timerText.value = '00:${seconds}sec';
  }

  void verifyOtp() async {
    if (otpController.text.length == 4) {
      try {
        // In a real app, you would call an API to verify the OTP
        await Future.delayed(const Duration(seconds: 2));
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
        'Please enter a valid 4-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resendOtp() async {
    try {
      // In a real app, you would call an API to resend the OTP
      await Future.delayed(const Duration(seconds: 1));
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