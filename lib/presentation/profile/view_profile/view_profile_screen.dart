import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/routes/app_pages.dart';

class ViewProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background color
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black), // Black text for title
        ),
        backgroundColor: const Color(0xFFF5F5F5), // Match background
        elevation: 0, // Remove shadow
        iconTheme: IconThemeData(color: Colors.black), // Black icons
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_pic.png'),
                backgroundColor: Colors.grey[200], // Fallback color
              ),
            ),
            const SizedBox(height: 16),
            // User Name
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A), // Primary text color
                ),
              ),
            ),
            const SizedBox(height: 8),
            // User Email
            Center(
              child: Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF757575), // Secondary text color
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons Section
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Primary button background
                    foregroundColor: Colors.white, // White text
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.MY_APPOINTMENTS); // Navigate to History
                  },
                  child: const Text('History'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.EDIT_PROFILE); // Navigate to Edit Profile
                  },
                  child: const Text('Personal Details'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.HOME); // Navigate to Settings
                  },
                  child: const Text('Settings'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.black), // Border color
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN); // Navigate to Login
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFF757575),
        backgroundColor: Colors.white,
        currentIndex: 1, // Set the Search tab as active
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
            label: 'Search',
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
    );
  }
}
