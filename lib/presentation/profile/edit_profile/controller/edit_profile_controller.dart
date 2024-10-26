// lib/presentation/profile/edit_profile/controller/edit_profile_controller.dart

import 'dart:io';
import 'package:dycare/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxBool isLoading = true.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  final Rx<File?> profileImage = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      user.value = await _userRepository.getCurrentUser();
      if (user.value != null) {
        _populateFields();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user profile');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    nameController.text = user.value!.name;
    emailController.text = user.value!.email;
    phoneController.text = user.value!.phoneNumber ?? '';
    addressController.text = user.value!.address ?? '';
    if (user.value!.role == UserRole.patient) {
      dateOfBirthController.text = DateTimeUtils.formatDate(user.value!.dateOfBirth!);
    } else if (user.value!.role == UserRole.nurse) {
      specializationController.text = user.value!.specialization ?? '';
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: user.value!.dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text = DateTimeUtils.formatDate(picked);
    }
  }

  Future<void> saveProfile() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final updatedUser = UserEntity(
          id: user.value!.id,
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          address: addressController.text,
          role: user.value!.role,
          dateOfBirth: user.value!.role == UserRole.patient
              ? DateTimeUtils.parseDate(dateOfBirthController.text)
              : null,
          specialization: user.value!.role == UserRole.nurse
              ? specializationController.text
              : null,
        );
        await _userRepository.updateUser(updatedUser);
        if (profileImage.value != null) {
          await _userRepository.updateProfilePicture(profileImage.value!);
        }
        Get.back(result: true);
        Get.snackbar('Success', 'Profile updated successfully');
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateOfBirthController.dispose();
    specializationController.dispose();
    super.onClose();
  }
}