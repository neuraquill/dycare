import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';

class AppointmentDetailsController extends GetxController {
  final Rx<NurseEntity?> selectedNurse = Rx<NurseEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get the nurse details passed from the previous screen
    final NurseEntity? nurse = Get.arguments;
    print("NurseEntity: $nurse");
    print("Nurse ID during details initilization: ${nurse?.id}");
    print("Nurse Name during details initilization: ${nurse?.name}");
    if (nurse != null) {
      selectedNurse.value = nurse;
    } else {
      Get.snackbar('Error', 'No nurse details found');
    }
  }
}