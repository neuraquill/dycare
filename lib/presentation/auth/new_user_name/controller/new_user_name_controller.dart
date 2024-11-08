// lib/presentation/auth/new_user_name/controller/new_user_name_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';

class NewUserNameController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  Future<void> submitName() async {
    if (formKey.currentState!.validate()) {
      try {
        final success = await _authRepository.updateUserName(
          nameController.text.trim(),
        );

        if (success) {
          Get.snackbar(
            'Welcome!',
            'Your profile has been created successfully.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar(
            'Error',
            'Failed to save your name. Please try again.',
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
    nameController.dispose();
    super.onClose();
  }
}