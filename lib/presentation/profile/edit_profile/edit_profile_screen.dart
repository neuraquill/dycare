import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/profile/edit_profile/controller/edit_profile_controller.dart';
import 'package:dycare/theme/app_colors.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.06;

    final fontSizes = ResponsiveFontSizes(
      tiny: screenHeight * 0.014,
      small: screenHeight * 0.016,
      medium: screenHeight * 0.018,
      large: screenHeight * 0.024,
      xlarge: screenHeight * 0.032,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: fontSizes.medium,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.textPrimary),
            onPressed: controller.saveProfile,
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.04),
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
                          radius: screenWidth * 0.15,
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
                            backgroundColor: AppColors.primaryDark,
                            radius: screenWidth * 0.05,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: AppColors.white),
                              onPressed: controller.pickImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 1.2),
                  // Full Name Field
                  _buildTextField(
                    controller: controller.nameController,
                    labelText: 'Full Name',
                    prefixIcon: Icons.person,
                    validator: InputValidators.validateName,
                    fontSizes: fontSizes,
                  ),
                  SizedBox(height: verticalSpacing),
                  // Email Field (Non-editable)
                  _buildTextField(
                    controller: controller.emailController,
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    validator: InputValidators.validateEmail,
                    fontSizes: fontSizes,
                  ),
                  SizedBox(height: verticalSpacing),
                  // Phone Number Field
                  _buildTextField(
                    controller: controller.phoneController,
                    labelText: 'Phone Number',
                    prefixIcon: Icons.phone,
                    validator: InputValidators.validatePhoneNumber,
                    fontSizes: fontSizes,
                  ),
                  SizedBox(height: verticalSpacing),
                  // Address Field
                  _buildTextField(
                    controller: controller.addressController,
                    labelText: 'Address',
                    prefixIcon: Icons.home,
                    validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Address'),
                    maxLines: 3,
                    fontSizes: fontSizes,
                  ),
                  SizedBox(height: verticalSpacing),
                  // Conditional Field for Patient (Date of Birth)
                  if (controller.user.value?.role == UserRole.patient)
                    _buildTextField(
                      controller: controller.dateOfBirthController,
                      labelText: 'Date of Birth',
                      prefixIcon: Icons.cake,
                      readOnly: true,
                      onTap: () => controller.selectDateOfBirth(context),
                      fontSizes: fontSizes,
                      validator: null, // Added to resolve the error
                    ),
                  SizedBox(height: verticalSpacing),
                  // Save Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      minimumSize: Size(double.infinity, screenHeight * 0.06),
                    ),
                    onPressed: controller.saveProfile,
                    child: Text(
                      'Save Changes', 
                      style: TextStyle(
                        color: AppColors.white, 
                        fontSize: fontSizes.medium
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    ResponsiveFontSizes? fontSizes,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors.textPrimary, 
          fontSize: fontSizes?.small
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.textPrimary),
        filled: true,
        fillColor: AppColors.inputFill,
        hintStyle: TextStyle(color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(
        color: AppColors.textPrimary, 
        fontSize: fontSizes?.medium
      ),
    );
  }
}

class ResponsiveFontSizes {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double xlarge;

  ResponsiveFontSizes({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.xlarge,
  });
}