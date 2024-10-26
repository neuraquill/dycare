import 'package:get/get.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';

class NurseDetailsController extends GetxController {
  final NurseRepository _nurseRepository = Get.find<NurseRepository>();

  final Rx<NurseEntity?> nurse = Rx<NurseEntity?>(null);
  final RxBool isLoading = true.obs;

  late String nurseDescription;

  @override
  void onInit() {
    super.onInit();
    final String nurseId = Get.arguments as String;
    loadNurseDetails(nurseId);
  }

  Future<void> loadNurseDetails(String nurseId) async {
    try {
      isLoading.value = true;
      nurse.value = await _nurseRepository.getNurseById(nurseId);
      if (nurse.value != null) {
        nurseDescription = await _nurseRepository.getNurseDescription(nurseId);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load nurse details');
    } finally {
      isLoading.value = false;
    }
  }
}