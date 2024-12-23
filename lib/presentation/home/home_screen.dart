import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/core/constants/app_constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppConstants.HOME_TITLE,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories Section (Fixed Grid)
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  // Nurses
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        'Notification',
                        'Functionality not decided',
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                      );
                    },
                    child: Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.primary, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_hospital, size: 48, color: AppColors.primary),
                            const SizedBox(height: 8),
                            Text(
                              'Nurses',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Physiotherapists
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        'Notification',
                        'Functionality not decided',
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                      );
                    },
                    child: Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.primary, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fitness_center, size: 48, color: AppColors.primary),
                            const SizedBox(height: 8),
                            Text(
                              'Physiotherapists',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Caretakers
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        'Notification',
                        'Functionality not decided',
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                      );
                    },
                    child: Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.primary, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.elderly, size: 48, color: AppColors.primary),
                            const SizedBox(height: 8),
                            Text(
                              'Caretakers',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Counsellors
                  GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        'Notification',
                        'Functionality not decided',
                        backgroundColor: AppColors.primary,
                        colorText: AppColors.white,
                      );
                    },
                    child: Card(
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: AppColors.primary, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, size: 48, color: AppColors.primary),
                            const SizedBox(height: 8),
                            Text(
                              'Counsellors',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Placeholder Section for List of Nurses
              Text(
                'Placeholder for list of nurses available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.inputBorder, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.white,
          currentIndex: 0,
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
              icon: Icon(Icons.schedule),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
