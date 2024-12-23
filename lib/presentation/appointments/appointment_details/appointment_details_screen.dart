import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/theme/custom_text_style.dart' as customTheme;
import 'package:dycare/presentation/appointments/appointment_details/controller/appointment_details_controller.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppointmentDetailsController controller = Get.find<AppointmentDetailsController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final nurse = controller.selectedNurse.value;
        if (nurse == null) {
          return Center(child: Text('No nurse details found'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(nurse),
              _buildSpecializationSection(nurse),
              _buildActionButtons(nurse),
              _buildReviewSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileSection(NurseEntity nurse) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nurse.name,
            style: customTheme.CustomTextStyle.titleLarge(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Education: ${nurse.education ?? "BSN"}',
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            '${nurse.yearsOfExp ?? "10"} years of experience',
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            nurse.education ?? "BSN",
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationSection(NurseEntity nurse) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Specialization',
            style: customTheme.CustomTextStyle.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            nurse.specialization ?? 'Pediatric Nursing',
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(NurseEntity nurse) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.message, color: Colors.white),
              label: Text(
                'Message',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B96EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B96EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Get.toNamed(Routes.BOOK_APPOINTMENT, arguments: nurse.id);
              },
              child: Text(
                'Book Consultation',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: customTheme.CustomTextStyle.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7B96EC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              onPressed: () {},
              child: Text(
                'Leave a Review',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}