import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/search/controller/search_controller.dart' as local;
import 'package:dycare/theme/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local.SearchController controller = Get.find<local.SearchController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth * 0.04;
    final verticalSpacing = screenHeight * 0.02;
    final cardRadius = screenWidth * 0.03;
    final avatarSize = screenWidth * 0.12;

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
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Nurses & Caretakers',
          style: TextStyle(
            fontSize: fontSizes.large,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: controller.filterNurses,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: fontSizes.small, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.inputFill,
                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: screenHeight * 0.015),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(cardRadius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: verticalSpacing * 1.2),
            // Nurse List
            Text(
              'List of Nurses',
              style: TextStyle(
                fontSize: fontSizes.medium,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: verticalSpacing),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredNurses.length,
                  itemBuilder: (context, index) {
                    final nurse = controller.filteredNurses[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.APPOINTMENT_DETAILS);
                      },
                      child: Card(
                        color: AppColors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(cardRadius),
                        ),
                        margin: EdgeInsets.only(bottom: verticalSpacing),
                        child: Padding(
                          padding: EdgeInsets.all(horizontalPadding),
                          child: Row(
                            children: [
                              // Nurse Image Placeholder
                              Container(
                                width: avatarSize,
                                height: avatarSize,
                                decoration: BoxDecoration(
                                  color: AppColors.inputBorder,
                                  borderRadius: BorderRadius.circular(cardRadius),
                                ),
                                child: nurse.profilePicture != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(cardRadius),
                                        child: Image.network(
                                          nurse.profilePicture!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(Icons.person, color: AppColors.black),
                              ),
                              SizedBox(width: horizontalPadding),
                              // Nurse Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nurse.name,
                                      style: TextStyle(
                                        fontSize: fontSizes.small,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      nurse.specialization ?? 'No specialization',
                                      style: TextStyle(
                                        fontSize: fontSizes.tiny,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      'Rating: ${nurse.rating}',
                                      style: TextStyle(
                                        fontSize: fontSizes.tiny,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: horizontalPadding),
                              // Availability & Action Button
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.75, vertical: screenHeight * 0.005),
                                    decoration: BoxDecoration(
                                      color: controller.isAvailable(nurse.availableDays)
                                          ? AppColors.success
                                          : AppColors.inputBorder,
                                      borderRadius: BorderRadius.circular(cardRadius),
                                    ),
                                    child: Text(
                                      controller.isAvailable(nurse.availableDays) ? 'Available' : 'Not Available',
                                      style: TextStyle(
                                        fontSize: fontSizes.tiny,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  ElevatedButton(
                                    onPressed: controller.isAvailable(nurse.availableDays)
                                        ? () {
                                            Get.toNamed(Routes.BOOK_APPOINTMENT);
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: controller.isAvailable(nurse.availableDays)
                                          ? AppColors.primary
                                          : AppColors.inputBorder,
                                      foregroundColor: AppColors.white,
                                      minimumSize: Size(screenWidth * 0.2, screenHeight * 0.045),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(cardRadius),
                                      ),
                                    ),
                                    child: Text(
                                      'Book',
                                      style: TextStyle(
                                        fontSize: fontSizes.tiny,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
          currentIndex: 1,
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