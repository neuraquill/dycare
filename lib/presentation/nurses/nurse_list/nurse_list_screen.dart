import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';

class NurseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.NURSE_LIST_TITLE),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual nurse list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Nurse ${index + 1}'),
            onTap: () => Get.toNamed(Routes.NURSE_DETAILS),
          );
        },
      ),
    );
  }
}