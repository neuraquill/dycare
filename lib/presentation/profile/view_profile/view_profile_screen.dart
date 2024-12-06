import 'package:dycare/presentation/profile/view_profile/controller/view_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/app_colors.dart';
import 'dart:io';

class ViewProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Picture Section
                      Center(
                        child: GestureDetector(
                          onTap: controller.isEditing.value ? controller.pickImage : null,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: controller.newProfileImage.value != null
                                ? FileImage(controller.newProfileImage.value!)
                                    : AssetImage('assets/images/profile_pic.png') as ImageProvider,
                            backgroundColor: AppColors.inputFill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // User Name
                      Center(
                        child: controller.isEditing.value
                            ? TextFormField(
                                controller: controller.nameController,
                                decoration: InputDecoration(labelText: 'Name'),
                                validator: (value) => value == null || value.isEmpty
                                    ? 'Name cannot be empty'
                                    : null,
                              )
                            : Text(
                                controller.user.value?.name ?? 'Unknown',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                      ),
                      const SizedBox(height: 8),

                      // User Phone
                      Center(
                        child: controller.isEditing.value
                            ? TextFormField(
                                controller: controller.phoneController,
                                decoration: InputDecoration(labelText: 'Phone'),
                                keyboardType: TextInputType.phone,
                                validator: (value) => value == null || value.isEmpty
                                    ? 'Phone cannot be empty'
                                    : null,
                              )
                            : Text(
                                controller.user.value?.phone ?? 'No phone provided',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),

                      // Edit Mode Toggle and Save Button
                      if (controller.isEditing.value)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          onPressed: controller.saveProfile,
                          child: const Text('Save'),
                        )
                      else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          onPressed: controller.toggleEditMode,
                          child: const Text('Edit Profile'),
                        ),

                      const SizedBox(height: 16),

                      // Action Buttons Section
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.MY_APPOINTMENTS);
                            },
                            child: const Text('History'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.HOME);
                            },
                            child: const Text('Settings'),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.textPrimary),
                              foregroundColor: AppColors.textPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            onPressed: () {
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.white,
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed(Routes.HOME);
              break;
            case 1:
              Get.toNamed(Routes.SEARCH);
              break;
            case 2:
              Get.toNamed(Routes.MY_APPOINTMENTS);
              break;
            case 3:
              Get.toNamed(Routes.VIEW_PROFILE);
              break;
            default:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
