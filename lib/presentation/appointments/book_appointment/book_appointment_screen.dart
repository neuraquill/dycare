//appointment_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dycare/theme/app_colors.dart';
import 'package:dycare/presentation/appointments/book_appointment/controller/book_appointment_controller.dart';

class BookAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the nurse ID passed from the previous screen
    final String nurseId = Get.arguments;
    print(nurseId);

    // Get the controller
    final BookAppointmentController controller = Get.find<BookAppointmentController>();

    // Set the selected nurse when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectNurseById(nurseId);
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppConstants.BOOK_APPOINTMENT_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        // Check if nurse is selected and data is loading
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Calendar for date selection
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
                    color: AppColors.textPrimary,
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
                    color: AppColors.textPrimary,
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
}
