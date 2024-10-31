import 'package:flutter/material.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:table_calendar/table_calendar.dart'; // Importing TableCalendar package for the calendar widget

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Calendar controller
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  // Time slot selection
  int? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); // Set the initial selected day to today
    _focusedDay = _selectedDay;
  }

  // Sample time slots
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppConstants.BOOK_APPOINTMENT_TITLE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back button to navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Standard padding
        child: Column(
          children: [
            // Calendar for date selection
            TableCalendar(
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // Update focused day
                });
              },
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 30)), // 30 days ahead
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.black, // Primary color for selected date
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300, // Color for today's date
                  shape: BoxShape.circle,
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing
            // Grid view for time slots
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0, // Spacing between columns
                  mainAxisSpacing: 16.0, // Spacing between rows
                ),
                itemCount: _timeSlots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTimeSlot = index; // Update selected time slot
                      });
                    },
                    child: Card(
                      elevation: 2,
                      color: _selectedTimeSlot == index
                          ? Colors.black // Highlight selected time slot
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _timeSlots[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _selectedTimeSlot == index
                                ? Colors.white // Text color for selected slot
                                : Colors.black, // Text color for unselected slot
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20), // Spacing
            // "Book Now" button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement booking functionality
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black), // Primary color
                minimumSize: MaterialStateProperty.all(Size(double.infinity, 48)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
              ),
              child: Text('Book Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
