// lib/presentation/auth/forgot_password/forgot_password_screen.dart

import 'package:dycare/theme/custom_text_style.dart' as customTheme;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/auth/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.FORGOT_PASSWORD_TITLE),
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
                  'Enter your email address and we\'ll send you instructions to reset your password.',
                  style: customTheme.CustomTextStyle.bodyMedium(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: InputValidators.validateEmail,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: CustomButtonStyle.primaryElevated,
                  onPressed: controller.resetPassword,
                  child: Text(AppConstants.RESET_PASSWORD_BUTTON),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}