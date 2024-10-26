// lib/presentation/auth/signup/controller/signup_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'package:dycare/domain/entities/user_entity.dart';

import '../../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final Rx<UserRole> selectedRole = UserRole.patient.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signup() async {
    if (formKey.currentState!.validate()) {
      try {
        bool success = await _authRepository.register(
          nameController.text,
          emailController.text,
          passwordController.text,
          selectedRole.value,
        );

        if (success) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar('Error', 'Registration failed. Please try again.');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred during registration');
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}