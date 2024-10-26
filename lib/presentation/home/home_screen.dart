import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.HOME_TITLE),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.BOOK_APPOINTMENT),
              child: Text('Book Appointment'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.NURSE_LIST),
              child: Text('View Nurses'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.CHAT_LIST),
              child: Text('Chats'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.VIEW_PROFILE),
              child: Text('View Profile'),
            ),
          ],
        ),
      ),
    );
  }
}