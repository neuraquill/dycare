// lib/presentation/search/controller/search_controller.dart

import 'package:get/get.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';
import 'package:intl/intl.dart';

class SearchController extends GetxController {
  final NurseRepository _nurseRepository;

  SearchController(this._nurseRepository);

  // Observable list to hold all nurses and filtered nurses
  final RxList<NurseEntity> allNurses = <NurseEntity>[].obs;
  final RxList<NurseEntity> filteredNurses = <NurseEntity>[].obs;

  // Observable for loading state
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadNurses();  // Load nurses when the controller is initialized
  }

  // Function to load nurses from the repository
  Future<void> loadNurses() async {
    try {
      isLoading.value = true;
      allNurses.value = await _nurseRepository.getAllNurses();
      filteredNurses.assignAll(allNurses);  // Initially display all nurses
    } catch (e) {
      Get.snackbar('Error', 'Failed to load nurses');
    } finally {
      isLoading.value = false;
    }
  }

  // Function to filter nurses based on search query
  void filterNurses(String query) {
    if (query.isEmpty) {
      filteredNurses.assignAll(allNurses);  // Show all nurses if query is empty
    } else {
      // Filter nurses based on name (case-insensitive)
      filteredNurses.assignAll(
        allNurses.where((nurse) => nurse.name.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
  // Method to check if the nurse is available today
  bool isAvailable(List<String> availableDays) {
    // Get the current day of the week (e.g., Monday, Tuesday)
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    
    // Check if the nurse is available on the current day
    return availableDays.contains(currentDay);
  }
}
