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
        backgroundColor: const Color(0xFFF5F5F5), // Primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Content padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_pic.png'), // Sample profile picture
              ),
            ),
            SizedBox(height: 16),
            // Profile name
            Center(
              child: Text(
                'John Doe', 
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppConstants.textPrimary), // Heading style
              ),
            ),
            SizedBox(height: 8),
            // Profile email
            Center(
              child: Text(
                'john.doe@example.com', 
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppConstants.textSecondary), // Body text style
              ),
            ),
            SizedBox(height: 24),

            // Buttons (History, Personal Details, Settings, Logout)
            Column(
              children: [
                ElevatedButton(
                  style: AppConstants.primaryButton, // Primary button style
                  onPressed: () {
                    // Navigate to the user's appointment history
                    // Replace with the actual route when implemented
                    Get.toNamed(Routes.HOME);
                  },
                  child: Text('History'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: AppConstants.primaryButton, // Primary button style
                  onPressed: () {
                    // Navigate to the Edit Profile screen
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  child: Text('Personal Details'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: AppConstants.primaryButton, // Primary button style
                  onPressed: () {
                    // Navigate to the Settings screen
                    Get.toNamed(Routes.HOME);
                  },
                  child: Text('Settings'),
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  style: AppConstants.secondaryButton, // Secondary button style
                  onPressed: () {
                    // Handle user logout
                    // Add actual logout logic if required
                    Get.offAllNamed(Routes.LOGIN); // Example of navigating to the login screen
                  },
                  child: Text('Logout'),
                ),
              ],
            ),

            // Add Bottom Navigation Bar (same as other screens)
            Spacer(),
            BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: const Color(0xFF757575),
            currentIndex: 3, // Set the default selected tab (optional)
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
          ),
          ],
        ),
      ),
    );
  }
}
