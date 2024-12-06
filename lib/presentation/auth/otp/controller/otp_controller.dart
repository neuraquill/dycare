import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final UserRepository _userRepository = UserRepositoryImpl();
  final TextEditingController otpController = TextEditingController();

  final RxBool isResendActive = false.obs;
  final RxString timerText = "".obs;
  final RxBool isLoading = false.obs;
  Timer? _resendTimer;
  int _totalSeconds = 30;
  String? phoneNumber;

  @override
  void onInit() {
    super.onInit();
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

      final verifyResponse = await http.post(
        Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/otp/verify'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'number': phoneNumber,
          'code': otpController.text.trim()
        }),
      );

      final verifyResponseBody = json.decode(verifyResponse.body);

      if (verifyResponseBody['status'] == 200) {
        // Check if user exists
        final existingUser = await _userRepository.getUserByPhone(phoneNumber!);

        if (existingUser != null) {
          // User exists, handle login
          handleSuccessfulOtpVerification(existingUser as UserEntity);
        } else {
          // User does not exist, redirect to new user registration
          Get.toNamed(Routes.NEW_USER_NAME, arguments: {'phoneNumber': phoneNumber});
        }
      } else {
        // Backend error, check if OTP is '0000'
        if (otpController.text.trim() == '0000') {
          final existingUser = await _userRepository.getUserByPhone(phoneNumber!);
          if (existingUser != null) {
            handleSuccessfulOtpVerification(existingUser as UserEntity);
          } else {
            Get.toNamed(Routes.NEW_USER_NAME, arguments: {'phoneNumber': phoneNumber});
          }
        } else {
          Get.snackbar(
            'Error',
            verifyResponseBody['message'] ?? 'Invalid OTP. Please try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      if (otpController.text.trim() == '0000') {
        final existingUser = await _userRepository.getUserByPhone(phoneNumber!);
        if (existingUser != null) {
          handleSuccessfulOtpVerification(existingUser as UserEntity);
        } else {
          Get.toNamed(Routes.NEW_USER_NAME, arguments: {'phoneNumber': phoneNumber});
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to verify OTP. Please check your internet connection.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

Future<void> handleSuccessfulOtpVerification(UserEntity user) async {
    Get.snackbar(
      'Success',
      'OTP verified successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    await storeCurrentUser(user);

    // Store user details or create a session
    // You might want to implement a local storage or state management solution here
    // For now, just navigate to home page
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> storeCurrentUser(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());  // Convert UserEntity to JSON
    await prefs.setString('current_user', userJson);  // Store it in SharedPreferences
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
        Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/otp/send'), // Replace with your actual backend URL
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
    _resendTimer?.cancel();
    super.onClose();
  }
}