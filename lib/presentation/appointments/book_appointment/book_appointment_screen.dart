import 'package:flutter/material.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dycare/theme/app_colors.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  int? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = _selectedDay;
  }

  final List<String> _timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalSpacing = screenHeight * 0.025;
    final horizontalPadding = screenWidth * 0.04;
    final buttonHeight = screenHeight * 0.065;

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
      body: Padding(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: screenHeight * 0.022,
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
            SizedBox(height: verticalSpacing),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: 2, // Adjust as needed for proper sizing
                ),
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeSlot = index;
                      });
                    },
                    child: Card(
                      elevation: 2,
                      color: _selectedTimeSlot == index
                          ? AppColors.textPrimary
                          : AppColors.textPrimaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Center(
                        child: Text(
                          _timeSlots[index],
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w600,
                            color: _selectedTimeSlot == index
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: verticalSpacing),
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement booking functionality
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  )),
                ),
                child: Text(
                  'Book Now', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.02,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}