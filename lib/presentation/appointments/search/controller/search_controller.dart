// lib/presentation/search/controller/search_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/search_repository.dart'; // Adjusted for dynamic repository
import 'package:intl/intl.dart';

class SearchController extends GetxController {
  final SearchRepository _searchRepository;

  SearchController(this._searchRepository);

  // Observable list to hold all nurses and filtered nurses
  final RxList<NurseEntity> allItems = <NurseEntity>[].obs;
  final RxList<NurseEntity> filteredItems = <NurseEntity>[].obs;

  // Observable for loading state
  final RxBool isLoading = true.obs;
  final RxString selectedProfession = 'all'.obs;


  @override
  void onInit() {
    super.onInit();
    loadItems('nurses');  // Default loading 'nurses', you can dynamically change this
  }

  // Function to load items (nurses, caretakers, etc.) from the repository
  Future<void> loadItems(String type) async {
    try {
      isLoading.value = true;
      allItems.value = await _searchRepository.getAllItems(type);
      
      // Add extensive logging
      print('Total items loaded: ${allItems.length}');
      for (var item in allItems) {
        print('Loaded item details:');
        print('Name: ${item.name}');
        print('Specialization: ${item.specialization}');
        print('Schedule: ${item.schedule}');
        print('Profile Picture: ${item.profilePicture}');
        print('---');
      }

      filteredItems.assignAll(allItems);
    } catch (e, stackTrace) {
      print("LoadItems error: $e");
      print("Stack trace: $stackTrace");
      
      // More detailed error handling
      Get.snackbar(
        'Error', 
        'Failed to load items: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 5)
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Function to filter items based on search query
  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(allItems);  // Show all items if query is empty
    } else {
      // Filter items based on name (case-insensitive)
      filteredItems.assignAll(
        allItems.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
  void filterByProfession(String profession) {
    if (profession == 'all') {
      // Show all items
      filteredItems.value = allItems;
    } else {
      // Filter by profession
      filteredItems.value = allItems.where(
        (item) => item.specialization?.toLowerCase() == profession.toLowerCase()
      ).toList();
    }
  }

  // Method to check if the item is available today
  bool isAvailable(Map<String, dynamic>? schedule) {
    try {
      // If schedule is null or empty, default to unavailable
      if (schedule == null) {
        print('Schedule is null');
        return false;
      }

      // If 'available' key doesn't exist or is not a list, default to unavailable
      final availableDays = schedule['available'];
      if (availableDays == null || availableDays is! List) {
        print('No available days or invalid format');
        return false;
      }

      // If the available days list is empty, you might want to have a default behavior
      if (availableDays.isEmpty) {
        print('Available days list is empty');
        
        // Option 1: Always available (uncomment if you want this behavior)
        // return true;
        
        // Option 2: Always unavailable (current behavior)
        return false;
      }

      String currentDay = DateFormat('EEEE').format(DateTime.now());
      bool isAvailable = List<String>.from(availableDays).contains(currentDay);
      
      print('Current day: $currentDay');
      print('Available days: $availableDays');
      print('Is available: $isAvailable');

      return isAvailable;
    } catch (e) {
      print('Error in isAvailable: $e');
      return false;
    }
  }
}
