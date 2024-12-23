import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/profile/edit_profile/controller/edit_profile_controller.dart';
import 'package:dycare/theme/app_colors.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Background color from AppColors
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimaryDark, // Primary text color
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryDark), // Primary text color for icons
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.textPrimaryDark), // Primary text color for icons
            onPressed: controller.saveProfile,
          ),
        ],
        backgroundColor: AppColors.background, // Background color for AppBar
        elevation: 0, // Flat AppBar
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image with Edit Button
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: controller.profileImage.value != null
                              ? FileImage(controller.profileImage.value!)
                              : (controller.user.value?.profilePicture != null
                                  ? NetworkImage(controller.user.value!.profilePicture!)
                                  : AssetImage('assets/images/default_profile.png')) as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryDark, // Primary dark color for button
                            radius: 20,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: AppColors.white),
                              onPressed: controller.pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Full Name Field
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: AppColors.textPrimaryDark),
                      prefixIcon: Icon(Icons.person, color: AppColors.textPrimaryDark),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      hintStyle: TextStyle(color: AppColors.textPrimaryDark),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: InputValidators.validateName,
                    style: TextStyle(color: AppColors.textPrimaryDark),
                  ),
                  SizedBox(height: 16),
                  // Email Field (Non-editable)
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: AppColors.textPrimaryDark),
                      prefixIcon: Icon(Icons.email, color: AppColors.textPrimaryDark),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: InputValidators.validateEmail,
                    style: TextStyle(color: AppColors.textPrimaryDark),
                  ),
                  SizedBox(height: 16),
                  // Phone Number Field
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: AppColors.textPrimaryDark),
                      prefixIcon: Icon(Icons.phone, color: AppColors.textPrimaryDark),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: InputValidators.validatePhoneNumber,
                    style: TextStyle(color: AppColors.textPrimaryDark),
                  ),
                  SizedBox(height: 16),
                  // Address Field
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: AppColors.textPrimaryDark),
                      prefixIcon: Icon(Icons.home, color: AppColors.textPrimaryDark),
                      filled: true,
                      fillColor: AppColors.inputFill,
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.inputBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Address'),
                    maxLines: 3,
                    style: TextStyle(color: AppColors.textPrimaryDark),
                  ),
                  SizedBox(height: 16),
                  // Conditional Field for Patient (Date of Birth)
                  if (controller.user.value?.role == UserRole.patient)
                    TextFormField(
                      controller: controller.dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        labelStyle: TextStyle(color: AppColors.textPrimaryDark),
                        prefixIcon: Icon(Icons.cake, color: AppColors.textPrimaryDark),
                        filled: true,
                        fillColor: AppColors.inputFill,
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.inputBorder),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      readOnly: true,
                      onTap: () => controller.selectDateOfBirth(context),
                      style: TextStyle(color: AppColors.textPrimaryDark),
                    ),
                  SizedBox(height: 16),
                  // Save Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    onPressed: controller.saveProfile,
                    child: Text('Save Changes', style: TextStyle(color: AppColors.white)),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
