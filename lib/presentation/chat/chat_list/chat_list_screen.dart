import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/constants/app_constants.dart';
import 'package:dycare/routes/app_routes.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.CHAT_LIST_TITLE),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual chat list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Chat ${index + 1}'),
            onTap: () => Get.toNamed(Routes.CHAT_DETAIL),
          );
        },
      ),
    );
  }
}