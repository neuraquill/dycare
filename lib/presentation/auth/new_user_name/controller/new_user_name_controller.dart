import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';

class NewUserNameController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final RxDouble latitude = RxDouble(0.0);
  final RxDouble longitude = RxDouble(0.0);
  final RxString currentAddress = RxString('');
  final RxBool isLoading = false.obs;
  String? phoneNumber;

  @override
  void onInit() {
    super.onInit();
    phoneNumber = Get.arguments?['phoneNumber'];
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar('Location Error', 'Location services are disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Location Error', 'Location permissions are permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude.value, longitude.value);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        currentAddress.value = 
          '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      Get.snackbar('Location Error', 'Failed to get current location');
    }
  }

  Future<void> submitDetails() async {
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

        final body = {
          'phone': phoneNumber,
          'name': nameController.text.trim(),
          'age': int.parse(ageController.text.trim()),
          'location': {
            'latitude': latitude.value,
            'longitude': longitude.value,
            'address': currentAddress.value,
          },
        };

        final response = await http.post(
          Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/register/user'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        );

        final responseBody = json.decode(response.body);

        if (response.statusCode == 200 && responseBody['status'] == 200) {
          Get.snackbar(
            'Success',
            'Your profile has been created successfully.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          final loginResponse = await http.post(
            Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/auth/login'),
            headers: {
              'Content-Type': 'application/json',
              'ownerID': responseBody['data']['userID'],
            },
          );

          final loginResponseBody = json.decode(loginResponse.body);

          if (loginResponseBody['status'] == 200) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar(
              'Error',
              loginResponseBody['message'] ?? 'Login failed. Please try again.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 18) {
      return 'User must be 18 or older';
    }
    return null;
  }
}