import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository = UserRepositoryImpl();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<UserEntity?> user = Rx(null);
  final RxBool isLoading = true.obs;
  
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  
  final Rx<File?> profileImage = Rx(null);
  final RxString currentAddress = RxString('');
  final RxDouble latitude = RxDouble(0.0);
  final RxDouble longitude = RxDouble(0.0);

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future loadUserProfile() async {
    try {
      isLoading.value = true;
      user.value = await _userRepository.getCurrentUser();
      if (user.value != null) {
        _populateFields();
      } else {
        // If no current user, try to get current location
        await _getCurrentLocation();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Error', 'Location services are disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location Error', 'Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location Error', 'Location permissions are permanently denied');
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    // Get address from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude.value, longitude.value);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      currentAddress.value = 
        '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      addressController.text = currentAddress.value;
    }
  }

  void _populateFields() {
    nameController.text = user.value!.name;
    phoneController.text = user.value!.phone;
    addressController.text = '${user.value!.location['street'] ?? ''}, ${user.value!.location['city'] ?? ''}, ${user.value!.location['country'] ?? ''}';
    latitude.value = user.value!.latitude;
    longitude.value = user.value!.longitude;
  }

  Future saveProfile() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        
        final location = {
          'street': addressController.text.split(',')[0].trim(),
          'city': addressController.text.split(',').length > 1 
            ? addressController.text.split(',')[1].trim() 
            : '',
          'country': addressController.text.split(',').length > 2 
            ? addressController.text.split(',')[2].trim() 
            : '',
          'latitude': latitude.value,
          'longitude': longitude.value,
        };
        Get.back(result: true);
        Get.snackbar('Success', 'Profile updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  Future selectDateOfBirth(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text = picked.toString().split(' ')[0];
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateOfBirthController.dispose();
    super.onClose();
  }
}