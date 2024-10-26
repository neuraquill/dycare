// lib/presentation/appointments/my_appointments/my_appointments_screen.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/appointments/my_appointments/controller/my_appointments_controller.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';

class MyAppointmentsScreen extends GetWidget<MyAppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.appointments.isEmpty) {
          return Center(child: Text('No appointments found'));
        } else {
          return ListView.builder(
            itemCount: controller.appointments.length,
            itemBuilder: (context, index) {
              return _buildAppointmentCard(controller.appointments[index]);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.BOOK_APPOINTMENT),
        child: Icon(Icons.add),
        tooltip: 'Book New Appointment',
      ),
    );
  }

  Widget _buildAppointmentCard(AppointmentEntity appointment) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          'Appointment with ${controller.getNurseName(appointment.nurseId)}',
          style: CustomTextStyle.titleMedium(),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Date: ${DateTimeUtils.formatDate(appointment.dateTime)}',
              style: CustomTextStyle.bodyMedium(),
            ),
            Text(
              'Time: ${DateTimeUtils.formatTime(appointment.dateTime)}',
              style: CustomTextStyle.bodyMedium(),
            ),
            SizedBox(height: 8),
            Text(
              'Status: ${appointment.status}',
              style: CustomTextStyle.bodyMedium(
                color: _getStatusColor(appointment.status),
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () => Get.toNamed(
          Routes.APPOINTMENT_DETAILS,
          arguments: appointment.id,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'scheduled':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return AppColors.textPrimary;
    }
  }
}