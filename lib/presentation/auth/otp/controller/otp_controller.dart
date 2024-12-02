import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController otpController = TextEditingController();

  final RxBool isResendActive = false.obs;
  final RxString timerText = "".obs;
  final RxBool isLoading = false.obs;
  Timer? _resendTimer;
  int _totalSeconds = 30; // Changed to 30 seconds
  String? phoneNumber;

  @override
  void onInit() {
    super.onInit();
    // Retrieve phone number passed from login screen
    phoneNumber = Get.arguments?['phoneNumber'];
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
    if (otpController.text.length != 4) {
      Get.snackbar(
        'Error',
        'Please enter a valid 4-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (phoneNumber == null) {
      Get.snackbar(
        'Error',
        'Phone number not found. Please go back and try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      // Send OTP verification request to backend
      final verifyResponse = await http.post(
        Uri.parse('http://192.168.29.9:3000/otp/verify'), // Replace with your actual backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'number': phoneNumber,
          'code': otpController.text.trim()
        }),
      );

      // Parse the verification response
      final verifyResponseBody = json.decode(verifyResponse.body);

      if (verifyResponseBody['status'] == 200) {
        // OTP verified successfully, now check user existence
        final loginResponse = await http.post(
          Uri.parse('http://192.168.29.9:3000/auth/login'), // Replace with your actual backend URL
          headers: {
            'Content-Type': 'application/json',
            'ownerID': phoneNumber ?? '' // Assuming phone number is used as ownerID
          },
          body: json.encode({
            'phoneNumber': phoneNumber
          }),
        );

        final loginResponseBody = json.decode(loginResponse.body);

        if (loginResponseBody['status'] == 200) {
          // User exists, proceed to home page
          Get.snackbar(
            'Success',
            'OTP verified successfully',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          
          // Navigate to home page and remove all previous routes
          Get.offAllNamed(Routes.HOME);
        } else {
          // User does not exist, redirect to new user registration
          Get.snackbar(
            'Info',
            'Please complete your profile',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          
          // Navigate to new user name registration page
          Get.offAllNamed(Routes.NEW_USER_NAME, arguments: {
            'phoneNumber': phoneNumber
          });
        }
      } else {
        // Handle OTP verification failure
        Get.snackbar(
          'Error',
          verifyResponseBody['message'] ?? 'Failed to verify OTP. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to verify OTP. Please check your internet connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  void resendOtp() async {
    if (phoneNumber == null) {
      Get.snackbar(
        'Error',
        'Phone number not found. Please go back and try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      // Send OTP resend request to backend
      final response = await http.post(
        Uri.parse('http://192.168.29.9:3000/otp/send'), // Replace with your actual backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'number': phoneNumber
        }),
      );

      // Parse the response
      final responseBody = json.decode(response.body);

      if (responseBody['status'] == 200) {
        // OTP resent successfully
        Get.snackbar(
          'Success',
          'OTP resent successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        startResendTimer();
      } else {
        // Handle resend failure
        Get.snackbar(
          'Error',
          responseBody['message'] ?? 'Failed to resend OTP. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please check your internet connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }
}