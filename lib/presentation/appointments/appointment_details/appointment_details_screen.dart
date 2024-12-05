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
      body: Obx(() {
        final nurse = controller.selectedNurse.value;
        
        if (nurse == null) {
          return Center(child: Text('No nurse details found'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorSection(nurse),
              _buildBiographySection(nurse),
              _buildBottomSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDoctorSection(NurseEntity nurse) {
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
            child: nurse.profilePicture != null && nurse.profilePicture!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    nurse.profilePicture!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      Icon(Icons.person, color: AppColors.textSecondary, size: 40),
                  ),
                )
              : Icon(
                  Icons.person,
                  color: AppColors.textSecondary,
                  size: 40,
                ),
          ),
          SizedBox(height: 16),
          Text(
            nurse.name,
            style: customTheme.CustomTextStyle.titleLarge(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            nurse.specialization ?? 'No specialization',
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
          if (nurse.yearsOfExp != null)
            Text(
              '${nurse.yearsOfExp} years of experience',
              style: customTheme.CustomTextStyle.bodyMedium(
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBiographySection(NurseEntity nurse) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: customTheme.CustomTextStyle.titleMedium(
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          Text(
            _buildNurseBiography(nurse),
            style: customTheme.CustomTextStyle.bodyMedium(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _buildNurseBiography(NurseEntity nurse) {
    List<String> biography = [];
    
    if (nurse.specialization != null) {
      biography.add('Specialization: ${nurse.specialization}');
    }
    
    if (nurse.education != null) {
      biography.add('Education: ${nurse.education}');
    }
    
    if (nurse.yearsOfExp != null) {
      biography.add('Years of Experience: ${nurse.yearsOfExp}');
    }
    
    if (nurse.location != null) {
      biography.add('Location: ${nurse.location}');
    }
    
    return biography.isNotEmpty 
      ? biography.join('\n') 
      : 'No additional information available';
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