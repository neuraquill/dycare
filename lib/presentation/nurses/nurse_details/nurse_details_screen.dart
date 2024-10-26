// lib/presentation/nurses/nurse_details/nurse_details_screen.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/theme/custom_text_style.dart' as theme_style;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/nurses/nurse_details/controller/nurse_details_controller.dart';

class NurseDetailsScreen extends GetWidget<NurseDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nurse Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.nurse.value == null) {
          return Center(child: Text('Nurse not found'));
        } else {
          final nurse = controller.nurse.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: nurse.profilePicture != null
                        ? NetworkImage(nurse.profilePicture!)
                        : AssetImage('assets/images/default_profile.png') as ImageProvider,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    nurse.name,
                    style: theme_style.CustomTextStyle.headlineMedium(),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    nurse.specialization,
                    style: CustomTextStyle.titleMedium(color: AppColors.textSecondary),
                  ),
                ),
                SizedBox(height: 24),
                _buildInfoCard(
                  title: 'Rating',
                  content: '${nurse.rating.toStringAsFixed(1)} / 5.0',
                  icon: Icons.star,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Available Days',
                  content: nurse.availableDays.join(', '),
                  icon: Icons.calendar_today,
                ),
                SizedBox(height: 24),
                Text(
                  'About',
                  style: CustomTextStyle.titleLarge(),
                ),
                SizedBox(height: 8),
                Text(
                  controller.nurseDescription,
                  style: CustomTextStyle.bodyMedium(),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: CustomButtonStyle.primaryElevated,
                  onPressed: () => Get.toNamed(Routes.BOOK_APPOINTMENT, arguments: nurse.id),
                  child: Text('Book Appointment'),
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  style: CustomButtonStyle.primaryOutlined,
                  onPressed: () => Get.toNamed(Routes.NURSE_REVIEWS, arguments: nurse.id),
                  child: Text('View Reviews'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoCard({required String title, required String content, required IconData icon}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyle.titleSmall(color: AppColors.textSecondary),
                ),
                SizedBox(height: 4),
                Text(
                  content,
                  style: CustomTextStyle.bodyLarge(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}