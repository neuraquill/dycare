import 'package:dycare/routes/app_pages.dart';
import 'package:dycare/widgets/healthcare_card.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Healthcare Professionals', // Updated heading
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
              onChanged: controller.filterItems,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.inputFill,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Sort By Dropdown
            Container(
              width: double.infinity, // Same width as search bar
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: DropdownButtonHideUnderline(
                child: Obx(() => DropdownButton<String>(
                  value: controller.selectedProfession.value,
                  hint: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Sort by Profession'),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: BorderRadius.circular(12),
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: 'all',
                      child: Text('All Professionals'),
                    ),
                    DropdownMenuItem(
                      value: 'nurse',
                      child: Text('Nurses'),
                    ),
                    DropdownMenuItem(
                      value: 'physiotherapist',
                      child: Text('Physiotherapists'),
                    ),
                    DropdownMenuItem(
                      value: 'caretaker',
                      child: Text('Caretakers'),
                    ),
                    DropdownMenuItem(
                      value: 'counsellor',
                      child: Text('Counsellors'),
                    ),
                  ],
                  onChanged: (value) {
                    controller.selectedProfession.value = value ?? 'all';
                    controller.filterByProfession(value ?? 'all');
                  },
                )),
              ),
            ),
            const SizedBox(height: 24),
            // List Title
            const Text(
              'Available Professionals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16), // Spacing
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())  // Show loading indicator
                    : ListView.builder(
  itemCount: controller.filteredItems.length,
  itemBuilder: (context, index) {
    final item = controller.filteredItems[index];
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.APPOINTMENT_DETAILS, arguments: item),
      child: HealthcareProviderCard(
        provider: item,
        isAvailable: controller.isAvailable(item.schedule),
        onTap: () => Get.toNamed(Routes.BOOK_APPOINTMENT, arguments: item.id),
      ),
    );
  },
)
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
          selectedItemColor: AppColors.primary,
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
