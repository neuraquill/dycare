import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';

class NewUserNameController extends GetxController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  
  final RxBool isLoading = false.obs;
  final RxBool isLocating = false.obs;
  
  String? phoneNumber;
  Position? currentPosition;

  @override
  void onInit() {
    super.onInit();
    // Retrieve phone number passed from OTP screen
    phoneNumber = Get.arguments?['phoneNumber'];
  }

  Future<void> getCurrentLocation() async {
    isLocating.value = true;
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately
        Get.snackbar(
          'Location Error',
          'Location permissions are permanently denied. Please enable them in device settings.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, 
        position.longitude
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = "${place.street}, ${place.subLocality}, "
                         "${place.locality}, ${place.administrativeArea} "
                         "${place.postalCode}, ${place.country}";
        
        addressController.text = address;
        currentPosition = position;
      }
    } catch (e) {
      Get.snackbar(
        'Location Error',
        'Failed to get current location. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLocating.value = false;
    }
  }

  Future<void> submitName() async {
    if (phoneNumber == null) {
      Get.snackbar(
        'Error',
        'Phone number not found. Please go back and try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Send request to create new user
        final response = await http.post(
          Uri.parse('http://192.168.29.9:3000/users/create'), // Replace with your actual backend URL
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'phoneNumber': phoneNumber,
            'name': nameController.text.trim(),
            'age': int.parse(ageController.text.trim()),
            'address': addressController.text.trim(),
            'location': currentPosition != null ? {
              'latitude': currentPosition!.latitude,
              'longitude': currentPosition!.longitude
            } : null,
          }),
        );

        // Parse the response
        final responseBody = json.decode(response.body);

        if (responseBody['status'] == 200) {
          // User created successfully
          Get.snackbar(
            'Welcome!',
            'Your profile has been created successfully.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Attempt to login with the new user
          final loginResponse = await http.post(
            Uri.parse('http://192.168.29.9:3000/auth/login'), // Replace with your actual backend URL
            headers: {
              'Content-Type': 'application/json',
              'ownerID': phoneNumber ?? ''
            },
            body: json.encode({
              'phoneNumber': phoneNumber
            }),
          );

          final loginResponseBody = json.decode(loginResponse.body);

          if (loginResponseBody['status'] == 200) {
            // Navigate to home page
            Get.offAllNamed(Routes.HOME);
          } else {
            // Fallback navigation if login fails
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          // Handle user creation failure
          Get.snackbar(
            'Error',
            responseBody['message'] ?? 'Failed to create profile. Please try again.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An error occurred. Please check your internet connection.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.onClose();
  }
}