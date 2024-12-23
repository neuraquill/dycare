import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/presentation/appointments/book_appointment/controller/book_appointment_controller.dart';

class BookAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String nurseId = Get.arguments;
    print("Nurse ID on book appointment page: $nurseId");

    final BookAppointmentController controller = Get.find<BookAppointmentController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setNurseId(nurseId);
      print("Selected nurse: $nurseId");
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppConstants.BOOK_APPOINTMENT_TITLE,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryDark,
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TableCalendar(
                focusedDay: controller.selectedDate.value ?? DateTime.now(),
                selectedDayPredicate: (day) => 
                  controller.selectedDate.value != null && 
                  isSameDay(controller.selectedDate.value!, day),
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectDate(selectedDay);
                },
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 365)),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: AppColors.primary,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.primary,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.transparent,
                  ),
                  defaultTextStyle: TextStyle(
                    color: AppColors.textPrimaryDark,
                  ),
                  outsideTextStyle: TextStyle(
                    color: AppColors.textSecondaryDark,
                  ),
                  weekendTextStyle: TextStyle(
                    color: AppColors.weekends,
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Shift Selection Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildShiftButton(
                    context, 
                    'Day Shift', 
                    controller.selectedShift.value == 'Day', 
                    () => controller.selectShift('Day')
                  ),
                  _buildShiftButton(
                    context, 
                    'Night Shift', 
                    controller.selectedShift.value == 'Night', 
                    () => controller.selectShift('Night')
                  ),
                  _buildShiftButton(
                    context, 
                    'Full Day', 
                    controller.selectedShift.value == 'Full', 
                    () => controller.selectShift('Full')
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Book Now button
              ElevatedButton(
                onPressed: controller.canBookAppointment() 
                    ? () => controller.bookAppointment() 
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.black;
                  }),
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ))),
                child: Text(
                  'Book Now', 
                  style: TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Helper method to create shift selection buttons
  Widget _buildShiftButton(
    BuildContext context, 
    String label, 
    bool isSelected, 
    VoidCallback onPressed
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primary : AppColors.primaryLight,
        foregroundColor: isSelected ? Colors.white : Colors.white,
      ),
      child: Text(label),
    );
  }
}