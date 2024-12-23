// new_user_name_controller.dart
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSuggestion {
  final String displayName;
  final double lat;
  final double lon;

  LocationSuggestion({
    required this.displayName,
    required this.lat,
    required this.lon,
  });

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) {
    return LocationSuggestion(
      displayName: json['display_name'] ?? '',
      lat: double.parse(json['lat'] ?? '0'),
      lon: double.parse(json['lon'] ?? '0'),
    );
  }
}

class NewUserNameController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  
  final RxDouble latitude = RxDouble(0.0);
  final RxDouble longitude = RxDouble(0.0);
  final RxString currentAddress = RxString('');
  final RxBool isLoading = false.obs;
  final locationSuggestions = <LocationSuggestion>[].obs;
  final isSearching = false.obs;
  
  String? phoneNumber;
  LocationSuggestion? selectedLocation;

  @override
  void onInit() {
    super.onInit();
    phoneNumber = Get.arguments?['phoneNumber'];
    _getCurrentLocation();
  }

  @override
  void onClose() {
    nameController.dispose();
    ageController.dispose();
    locationController.dispose();
    super.onClose();
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
        locationController.text = currentAddress.value;
      }
    } catch (e) {
      Get.snackbar('Location Error', 'Failed to get current location');
    }
  }

  Future<void> searchLocation(String query) async {
    if (query.length < 3) {
      locationSuggestions.clear();
      return;
    }

    isSearching.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          'https://nominatim.openstreetmap.org/search?format=json&q=${Uri.encodeComponent(query)}',
        ),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'DyCare App'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        locationSuggestions.value = data
            .take(5)
            .map((json) => LocationSuggestion.fromJson(json))
            .toList();
      }
    } catch (e) {
      print('Error searching location: $e');
    } finally {
      isSearching.value = false;
    }
  }

  void setSelectedLocation(LocationSuggestion location) {
    selectedLocation = location;
    locationController.text = location.displayName;
    latitude.value = location.lat;
    longitude.value = location.lon;
    locationSuggestions.clear();
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
          },
        };

        final response = await http.post(
          Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/register/user'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        );

        final responseBody = json.decode(response.body);

        if (response.statusCode == 200 && responseBody['status'] == 200) {
          final data = json.decode(response.body)['data'];
          var newUser = UserEntity.fromJson({
            'id': data['userID'],
            'name': body['name'],
            'age': body['age'],
            'location': body['location'],
            'phone': body['phone'],
          });
          
          final loginResponse = await http.post(
            Uri.parse('https://hono-on-vercel-swart-one.vercel.app/api/auth/login'),
            headers: {
              'Content-Type': 'application/json',
              'ownerID': responseBody['data']['userID'],
            },
          );

          final loginResponseBody = json.decode(loginResponse.body);

          if (loginResponseBody['status'] == 200) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('current_user', json.encode({
              'id': responseBody['data']['userID'],
              'name': body['name'],
              'age': body['age'],
              'location': body['location'],
              'phone': body['phone'],
            }));
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