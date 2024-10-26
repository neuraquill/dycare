// lib/presentation/appointments/appointment_details/appointment_details_screen.dart

import 'package:dycare/theme/custom_text_style.dart' as customTheme;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/appointments/appointment_details/controller/appointment_details_controller.dart';

class AppointmentDetailsScreen extends GetWidget<AppointmentDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.appointment.value == null) {
          return Center(child: Text('Appointment not found'));
        } else {
          final appointment = controller.appointment.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCard(
                  title: 'Appointment ID',
                  content: appointment.id,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Date & Time',
                  content: DateTimeUtils.formatDateTime(appointment.dateTime),
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Status',
                  content: appointment.status,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Nurse',
                  content: controller.nurseName.value,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Patient',
                  content: controller.patientName.value,
                ),
                SizedBox(height: 16),
                _buildInfoCard(
                  title: 'Notes',
                  content: appointment.notes ?? 'No notes available',
                ),
                SizedBox(height: 24),
                if (appointment.status == 'Scheduled')
                  ElevatedButton(
                    style: CustomButtonStyle.primaryElevated,
                    onPressed: controller.cancelAppointment,
                    child: Text('Cancel Appointment'),
                  ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: customTheme.CustomTextStyle.titleMedium(color: AppColors.textSecondary),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: CustomTextStyle.bodyLarge(),
            ),
          ],
        ),
      ),
    );
  }
}