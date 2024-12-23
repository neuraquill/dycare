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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Info Section
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: controller.newProfileImage.value != null
                                  ? FileImage(controller.newProfileImage.value!)
                                  : AssetImage('assets/images/profile_pic.png') as ImageProvider,
                              backgroundColor: AppColors.inputFill,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              controller.user.value?.name ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '+91 ${controller.user.value?.phone ?? 'No phone provided'}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(Icons.verified, color: Colors.blue, size: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Menu Buttons Section
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildMenuButton(
                              'Previous Appointments',
                              Icons.history,
                              () => Get.toNamed(Routes.MY_APPOINTMENTS),
                            ),
                            _buildDivider(),
                            _buildMenuButton(
                              'Invoices and Bills',
                              Icons.receipt_long,
                              () => Get.toNamed(Routes.MY_APPOINTMENTS),
                            ),
                            _buildDivider(),
                            _buildMenuButton(
                              'Account',
                              Icons.person_outline,
                              () => Get.toNamed(Routes.EDIT_PROFILE),
                            ),
                            _buildDivider(),
                            _buildMenuButton(
                              'App Settings',
                              Icons.settings,
                              () => Get.toNamed(Routes.EDIT_PROFILE),
                            ),
                            _buildDivider(),
                            _buildMenuButton(
                              'Logout',
                              Icons.logout,
                              () => Get.offAllNamed(Routes.LOGIN),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildMenuButton(String title, IconData icon, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: AppColors.background);
  }
}