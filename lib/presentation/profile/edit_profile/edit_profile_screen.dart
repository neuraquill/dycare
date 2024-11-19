import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/profile/edit_profile/controller/edit_profile_controller.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black, // Use black color for the title
            fontSize: 20, // Adjust font size
            fontWeight: FontWeight.bold, // Bold title for emphasis
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Set icon color to black
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black), // Set icon color to black
            onPressed: controller.saveProfile,
          ),
        ],
        backgroundColor: Colors.white, // Set AppBar background to white
        elevation: 0, // Remove elevation for a flat AppBar
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16), // Standard padding
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
                            backgroundColor: Colors.black, // Black button for edit
                            radius: 20,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt, color: Colors.white),
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
                      labelStyle: TextStyle(color: Colors.black), // Black label text
                      prefixIcon: Icon(Icons.person, color: Colors.black), // Black icon
                      filled: true,
                      fillColor: Colors.grey[200], // Light grey background for fields
                      hintStyle: TextStyle(color: Colors.black), // Black hint text
                    ),
                    validator: InputValidators.validateName,
                    style: TextStyle(color: Colors.black), // Black text for input
                  ),
                  SizedBox(height: 16),
                  // Email Field (Non-editable)
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    validator: InputValidators.validateEmail,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  // Phone Number Field
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    validator: InputValidators.validatePhoneNumber,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  // Address Field
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.home, color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Address'),
                    maxLines: 3,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  // Conditional Field for Patient (Date of Birth)
                  if (controller.user.value?.role == UserRole.patient)
                    TextFormField(
                      controller: controller.dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.cake, color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      readOnly: true,
                      onTap: () => controller.selectDateOfBirth(context),
                      style: TextStyle(color: Colors.black),
                    ),
                  // Conditional Field for Nurse (Specialization)
                  if (controller.user.value?.role == UserRole.nurse)
                    TextFormField(
                      controller: controller.specializationController,
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.work, color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Specialization'),
                      style: TextStyle(color: Colors.black),
                    ),
                  SizedBox(height: 24),
                  // Save Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black, // White text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 48),
                    ),
                    onPressed: controller.saveProfile,
                    child: Text('Save Changes', style: TextStyle(color: Colors.white)),
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
