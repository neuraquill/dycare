import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';

class ViewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.PROFILE_TITLE),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('john.doe@example.com'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.EDIT_PROFILE),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}