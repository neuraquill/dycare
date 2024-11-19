// And update the controller
// lib/presentation/auth/login/controller/login_controller.dart
import 'package:dycare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController(this._userRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> sendOTP() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      // Here you would typically make an API call to send OTP
      await Future.delayed(const Duration(seconds: 1)); // Simulating API call
      
      // Navigate to OTP screen
      Get.toNamed(
        Routes.OTP,
        arguments: {'phoneNumber': phoneController.text.trim()}
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
