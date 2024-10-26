// lib/presentation/profile/controller/profile_controller.dart

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/core/utils/input_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final UserRepository _userRepository;
  final AppointmentRepository _appointmentRepository;

  ProfileController(this._userRepository, this._appointmentRepository);

  final Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxList<AppointmentEntity> recentAppointments = <AppointmentEntity>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isEditing = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
      user.value = await _userRepository.getCurrentUser();
      if (user.value != null) {
        _populateTextControllers();
        await loadRecentAppointments();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data');
    } finally {
      isLoading.value = false;
    }
  }

  void _populateTextControllers() {
    nameController.text = user.value?.name ?? '';
    emailController.text = user.value?.email ?? '';
    phoneController.text = user.value?.phoneNumber ?? '';
    addressController.text = user.value?.address ?? '';
  }

  Future<void> loadRecentAppointments() async {
    try {
      final userId = user.value?.id;
      if (userId != null) {
        recentAppointments.value = await _appointmentRepository.getRecentAppointments(userId);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load recent appointments');
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
      final updatedUser = user.value!.copyWith(
        name: nameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
      );

      await _userRepository.updateUser(updatedUser);

      if (newProfileImage.value != null) {
        await _userRepository.updateProfilePicture(newProfileImage.value!);
      }

      user.value = await _userRepository.getCurrentUser();
      isEditing.value = false;
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }

  String? validateName(String? value) => InputValidators.validateName(value);
  String? validatePhone(String? value) => InputValidators.validatePhoneNumber(value);
  String? validateAddress(String? value) => InputValidators.validateNotEmpty(value, 'Address');

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}