// lib/presentation/auth/login/controller/login_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/core/utils/input_validators.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController(this._userRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final user = await _userRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );

      Get.offAllNamed(Routes.HOME);
        } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during login',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void navigateToSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }

  String? validateEmail(String? value) {
    return InputValidators.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return InputValidators.validatePassword(value);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}