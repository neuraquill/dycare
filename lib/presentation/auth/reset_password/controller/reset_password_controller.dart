// lib/presentation/auth/reset_password/controller/reset_password_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';

class ResetPasswordController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final success = await _authRepository.resetPassword(
          resetCodeController.text,
          newPasswordController.text,
        );

        if (success) {
          Get.snackbar(
            'Success',
            'Your password has been reset successfully.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.LOGIN);
        } else {
          Get.snackbar(
            'Error',
            'Failed to reset password. Please try again.',
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
    resetCodeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}