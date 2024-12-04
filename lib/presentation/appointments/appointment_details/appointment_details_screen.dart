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
            _buildDoctorSection(),
            _buildBiographySection(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.image,
              color: AppColors.textSecondary,
              size: 40,
            ),
          ),
          SizedBox(height: 16),
          Text(
            doctorInfo['name']!,
            style: customTheme.CustomTextStyle.titleLarge(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
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

  Widget _buildBiographySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biography',
            style: customTheme.CustomTextStyle.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
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

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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