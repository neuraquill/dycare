import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class AppointmentDetailsController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  final Rx<AppointmentEntity?> appointment = Rx<AppointmentEntity?>(null);
  final RxBool isLoading = true.obs;
  final RxString nurseName = 'Unknown Nurse'.obs; // Default value
  final RxString patientName = 'Unknown Patient'.obs; // Default value

  @override
  void onInit() {
    super.onInit();
    final String? appointmentId = Get.arguments as String?;
    if (appointmentId != null && appointmentId.isNotEmpty) {
      loadAppointmentDetails(appointmentId);
    } else {
      Get.snackbar('Error', 'Invalid Appointment ID');
    }
  }

  Future<void> loadAppointmentDetails(String appointmentId) async {
    try {
      isLoading.value = true;
      appointment.value = await _appointmentRepository.getAppointmentById(appointmentId);
      if (appointment.value != null) {
        await _loadNurseAndPatientNames();
      } else {
        Get.snackbar('Error', 'Appointment not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load appointment details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadNurseAndPatientNames() async {
    try {
      final nurse = await _userRepository.getUserById(appointment.value!.nurseId);
      final patient = await _userRepository.getUserById(appointment.value!.patientId);
      nurseName.value = nurse?.name ?? 'Unknown Nurse';
      patientName.value = patient?.name ?? 'Unknown Patient';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load nurse and patient details');
    }
  }

  Future<void> cancelAppointment() async {
    try {
      await _appointmentRepository.cancelAppointment(appointment.value!.id);
      appointment.value = appointment.value!.copyWith(status: 'Cancelled');
      Get.snackbar('Success', 'Appointment cancelled successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel appointment');
    }
  }
}
