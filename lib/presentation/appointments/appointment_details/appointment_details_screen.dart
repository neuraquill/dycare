import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/theme/custom_text_style.dart' as customTheme;

class AppointmentDetailsScreen extends StatelessWidget {
  final Map<String, String> doctorInfo = {
    'name': 'Dr. Andrew',
    'description': 'Dr. Andrew is an experienced dentist with over 10 years of practice. He specializes in general dentistry and offers a range of services.',
    'biography': 'I am an experienced dentist with over 10 years of practice. I am specialized in general dentistry and I will offer a range of services.',
  };

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.04;
    final imageSize = screenWidth * 0.25;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Appointment',
          style: customTheme.CustomTextStyle.titleLarge(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorSection(screenWidth, screenHeight, imageSize, verticalSpacing, horizontalPadding),
            _buildBiographySection(horizontalPadding, verticalSpacing),
            _buildBottomSection(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorSection(double screenWidth, double screenHeight, double imageSize, double verticalSpacing, double horizontalPadding) {
    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Icon(
              Icons.image,
              color: AppColors.textSecondary,
              size: screenWidth * 0.1,
            ),
          ),
          SizedBox(height: verticalSpacing),
          Text(
            doctorInfo['name']!,
            style: customTheme.CustomTextStyle.titleLarge(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: verticalSpacing * 0.5),
          Text(
            doctorInfo['description']!,
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection(double horizontalPadding, double verticalSpacing) {
    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biography',
            style: customTheme.CustomTextStyle.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: verticalSpacing),
          Text(
            doctorInfo['biography']!,
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(double screenWidth, double screenHeight) {
    final buttonHeight = screenHeight * 0.065;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
              ),
              onPressed: () {
                // Redirect to Book Appointment Screen
                Get.toNamed(Routes.BOOK_APPOINTMENT);
              },
              child: Text(
                'Book an Appointment',
                style: customTheme.CustomTextStyle.buttonLarge(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}