import 'package:dycare/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/search/controller/search_controller.dart' as local;
import 'package:dycare/theme/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local.SearchController controller = Get.find<local.SearchController>();

    return Scaffold(
      backgroundColor: AppColors.background, // Background color
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Nurses & Caretakers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: controller.filterNurses,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: const Icon(Icons.mic, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.inputFill,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24), // Spacing
            // Nurse List
            const Text(
              'List of Nurses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16), // Spacing
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredNurses.length,
                  itemBuilder: (context, index) {
                    final nurse = controller.filteredNurses[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Nurse Image Placeholder (if profilePicture is provided)
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.inputBorder,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: nurse.profilePicture != null
                                  ? Image.network(nurse.profilePicture!)
                                  : const Icon(Icons.person, color: AppColors.white),
                            ),
                            const SizedBox(width: 16), // Spacing
                            // Nurse Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nurse.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    nurse.specialization ?? 'No specialization',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rating: ${nurse.rating}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16), // Spacing
                            // Availability & Action Button
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: controller.isAvailable(nurse.availableDays)
                                        ? AppColors.success
                                        : AppColors.inputBorder,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    controller.isAvailable(nurse.availableDays) ? 'Available' : 'Not Available',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: controller.isAvailable(nurse.availableDays) ? () {} : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.black,
                                    foregroundColor: AppColors.white,
                                    minimumSize: const Size(80, 36),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text('Book'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.inputBorder, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.textSecondary,
          backgroundColor: AppColors.white,
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
      ),
    );
  }
}
