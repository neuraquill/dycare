import 'package:dycare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
  }


  final UserRepository _userRepository;

  LoginController(this._userRepository);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeNotifications() {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // Ensure this matches your app's icon
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showErrorNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'error_channel', // Channel ID
      'Error Notifications', // Channel Name
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // Notification ID
      'DYCARE',
      'OTP is 0000.',
      notificationDetails,
    );
  }


  Future<void> sendOTP() async {
    print("sendOTP() called"); // Debugging print statement

    if (!formKey.currentState!.validate()) {
      print("Form validation failed"); // Debugging print statement
      return;
    }

    try {
      print("Form validation succeeded. Preparing to send OTP...");

      isLoading.value = true;

      // Send OTP request to backend
      print("Sending OTP request to backend...");
      final response = await http.post(
        Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/otp/send'), // Replace with your actual backend URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'number': phoneController.text.trim(),
        }),
      );

      print("Response received from backend. Parsing response...");
      final responseBody = json.decode(response.body);
      print("Response body: $responseBody"); // Debugging response body

      if (responseBody['status'] == 200) {
        print("OTP sent successfully. Navigating to OTP screen...");
        Get.toNamed(
          Routes.OTP,
          arguments: {'phoneNumber': phoneController.text.trim()},
        );
      } else {
        print("Failed to send OTP. Showing error message...");
        showErrorNotification();
      }
    } catch (e) {
      print("An error occurred: $e"); // Print the caught exception
      showErrorNotification();
    } finally {
      print("Resetting loading state...");
      Get.toNamed(
          Routes.OTP,
          arguments: {'phoneNumber': phoneController.text.trim()},
      );
      isLoading.value = false;
    }
  }

  String? validatePhone(String? value) {
    print("Validating phone number: $value"); // Debugging print statement

    if (value == null || value.isEmpty) {
      print("Validation failed: Phone number is empty");
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      print("Validation failed: Invalid phone number format");
      return 'Please enter a valid 10-digit phone number';
    }

    print("Phone number validation succeeded");
    return null;
  }

  @override
  void onClose() {
    print("Closing LoginController. Disposing resources...");
    phoneController.dispose();
    super.onClose();
  }
}
