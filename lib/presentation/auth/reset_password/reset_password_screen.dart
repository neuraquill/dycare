// lib/presentation/auth/reset_password/reset_password_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/reset_password/controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetWidget<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.RESET_PASSWORD_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Text(
                  'Enter your reset code and new password',
                  style: CustomTextStyle.bodyLarge(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: controller.resetCodeController,
                  decoration: InputDecoration(
                    labelText: 'Reset Code',
                    prefixIcon: Icon(Icons.lock_open),
                  ),
                  validator: (value) => InputValidators.validateNotEmpty(value, 'Reset Code'),
                ),
                SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.newPasswordController,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  obscureText: !controller.isPasswordVisible.value,
                  validator: InputValidators.validatePassword,
                )),
                SizedBox(height: 16),
                TextFormField(
                  controller: controller.confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) => InputValidators.validateConfirmPassword(
                    value,
                    controller.newPasswordController.text,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: CustomButtonStyle.primaryElevated,
                  onPressed: controller.resetPassword,
                  child: Text(AppConstants.RESET_PASSWORD_BUTTON),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}