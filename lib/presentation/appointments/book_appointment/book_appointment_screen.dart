import 'package:flutter/material.dart';
import 'package:dycare/core/constants/app_constants.dart';

class BookAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.BOOK_APPOINTMENT_TITLE),
      ),
      body: Center(
        child: Text('Book Appointment Screen - Implement booking form here'),
      ),
    );
  }
}