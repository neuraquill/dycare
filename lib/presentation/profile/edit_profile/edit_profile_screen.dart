// lib/presentation/profile/edit_profile/edit_profile_screen.dart

import 'package:dycare/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/profile/edit_profile/controller/edit_profile_controller.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: controller.saveProfile,
          ),
        ],
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
                            backgroundColor: AppColors.primary,
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
                  TextFormField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: InputValidators.validateName,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: InputValidators.validateEmail,
                    enabled: false, // Email is usually not editable
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: InputValidators.validatePhoneNumber,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.home),
                    ),
                    validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Address'),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  if (controller.user.value?.role == UserRole.patient)
                    TextFormField(
                      controller: controller.dateOfBirthController,
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.cake),
                      ),
                      readOnly: true,
                      onTap: () => controller.selectDateOfBirth(context),
                    ),
                  if (controller.user.value?.role == UserRole.nurse)
                    TextFormField(
                      controller: controller.specializationController,
                      decoration: InputDecoration(
                        labelText: 'Specialization',
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: (value) => InputValidators.validateNotEmpty(value ?? '', 'Specialization'),
                    ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: CustomButtonStyle.primaryElevated,
                    onPressed: controller.saveProfile,
                    child: Text('Save Changes'),
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