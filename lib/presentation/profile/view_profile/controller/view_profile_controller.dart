import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  ProfileController(this._userRepository);

  final Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isEditing = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final Rx<File?> newProfileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser != null) {
        user.value = currentUser;
        _populateTextControllers();
      } else {
        Get.snackbar('Error', 'No user data found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateTextControllers() {
    if (user.value != null) {
      nameController.text = user.value?.name ?? '';
      phoneController.text = user.value?.phone ?? '';
      ageController.text = user.value?.age.toString() ?? '';
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      _populateTextControllers();
      newProfileImage.value = null;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      newProfileImage.value = File(image.path);
    }
  }

  Future<void> saveProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      if (newProfileImage.value != null) {
        await _userRepository.updateProfilePicture(newProfileImage.value!);
      }

      // Updating the user data in the repository (dummy logic for now)
      user.value = await _userRepository.updateUser(
        UserEntity(
          id: user.value?.id ?? '',
          name: nameController.text,
          phone: phoneController.text, age: int.parse(ageController.text), location: {
            'latitude': user.value?.location['latitude'] ?? 0.0,
            'longitude': user.value?.location['longitude'] ?? 0.0,
          },
        ),
      );

      isEditing.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
