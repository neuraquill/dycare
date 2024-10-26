// lib/presentation/auth/forgot_password/controller/forgot_password_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  void resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        bool success = await _authRepository.resetPassword(emailController.text, "admin");

        if (success) {
          Get.snackbar(
            'Success',
            'Password reset instructions have been sent to your email.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.snackbar(
            'Error',
            'Failed to send reset instructions. Please try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An error occurred. Please try again later.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}