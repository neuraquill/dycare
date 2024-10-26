import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:dycare/theme/custom_text_style.dart';
import 'package:dycare/theme/custom_button_style.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.LOGIN_TITLE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppConstants.EMAIL_PLACEHOLDER,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: AppConstants.PASSWORD_PLACEHOLDER,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: CustomButtonStyle.primaryElevated,
              onPressed: () {
                // Implement login logic
                Get.offAllNamed(Routes.HOME);
              },
              child: Text(AppConstants.LOGIN_BUTTON),
            ),
            TextButton(
              style: CustomButtonStyle.primaryText,
              onPressed: () {
                Get.toNamed(Routes.SIGNUP);
              },
              child: Text(AppConstants.SIGNUP_BUTTON),
            ),
          ],
        ),
      ),
    );
  }
}