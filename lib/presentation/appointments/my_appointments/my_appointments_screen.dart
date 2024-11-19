// lib/presentation/appointments/my_appointments/my_appointments_screen.dart

import 'package:dycare/core/utils/date_time_utils.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/presentation/appointments/my_appointments/controller/my_appointments_controller.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';

class MyAppointmentsScreen extends GetWidget<MyAppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Appointments',
          style: AppTypography.heading1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelectionStrip(),
            const SizedBox(height: 16),
            _buildStatusFilterTabs(),
            const SizedBox(height: 16),
            Expanded(child: _buildAppointmentList()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.BOOK_APPOINTMENT),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDateSelectionStrip() {
    // A horizontal scrollable strip with dates
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: index == 0 ? AppColors.primary : AppColors.accentPink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Mon 8',
                    style: AppTypography.bodyLarge.copyWith(
                      color: index == 0 ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mon',
                    style: AppTypography.bodyMedium.copyWith(
                      color: index == 0 ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatusFilterTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatusTab("Upcoming", true),
        _buildStatusTab("Completed", false),
        _buildStatusTab("Cancelled", false),
      ],
    );
  }

  Widget _buildStatusTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.booked,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.appointments.isEmpty) {
        return Center(child: Text('No appointments found', style: AppTypography.bodyLarge));
      } else {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          itemCount: controller.appointments.length,
          itemBuilder: (context, index) {
            return _buildAppointmentCard(controller.appointments[index]);
          },
        );
      }
    });
  }

  Widget _buildAppointmentCard(AppointmentEntity appointment) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTimeUtils.formatTime(appointment.dateTime),
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(width: 16),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ${controller.getNurseName(appointment.nurseId)}',
                    style: AppTypography.heading2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Specialty',
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () => Get.toNamed(Routes.APPOINTMENT_DETAILS, arguments: appointment.id),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary, side: BorderSide(color: AppColors.primary),
                  ),
                  child: const Text("View"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
    unselectedItemColor: const Color(0xFF757575),
    currentIndex: 2, // Assumes 'Appointments' is selected by default
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
        label: 'Categories',
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
  );
}

}
