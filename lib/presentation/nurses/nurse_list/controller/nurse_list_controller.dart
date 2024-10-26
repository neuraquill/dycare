// lib/presentation/nurses/nurse_list/controller/nurse_list_controller.dart

import 'package:get/get.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';

class NurseListController extends GetxController {
  final NurseRepository _nurseRepository;

  NurseListController(this._nurseRepository);

  final RxList<NurseEntity> nurses = <NurseEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedSpecialization = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadNurses();
  }

  Future<void> loadNurses() async {
    try {
      isLoading.value = true;
      nurses.value = await _nurseRepository.getNurses(
        specialization: selectedSpecialization.value.isNotEmpty ? selectedSpecialization.value : null,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load nurses');
    } finally {
      isLoading.value = false;
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    filterNurses();
  }

  void setSpecialization(String specialization) {
    selectedSpecialization.value = specialization;
    loadNurses();
  }

  void filterNurses() {
    if (searchQuery.value.isEmpty) {
      loadNurses();
    } else {
      nurses.value = nurses.where((nurse) =>
        nurse.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        nurse.specialization.toLowerCase().contains(searchQuery.value.toLowerCase())
      ).toList();
    }
  }

  void navigateToNurseDetails(String nurseId) {
    Get.toNamed('/nurse-details', arguments: nurseId);
  }
}