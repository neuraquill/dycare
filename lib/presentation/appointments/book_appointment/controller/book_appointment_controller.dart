import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/search_repository.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class BookAppointmentController extends GetxController {
  final AppointmentRepository _appointmentRepository;
  final UserRepository _userRepository;
  final SearchRepository _searchRepository;

  BookAppointmentController(
    this._appointmentRepository,
    this._userRepository,
    this._searchRepository,
  );

  late String nurseId;
  final RxString selectedNurseId = ''.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedTime = Rx<DateTime?>(null);
  final RxList<DateTime> availableSlots = <DateTime>[].obs;
  final RxBool isLoading = false.obs;
  
  void setNurseId(String id) {
    nurseId = id;
    selectedDate.value = null;
    selectedTime.value = null;
    availableSlots.clear();
  }

  Future<void> selectNurseById(String nurseId) async {
    isLoading.value = true;
    try {
      // Fetch nurse details using the updated repository method
      NurseEntity nurse = await _searchRepository.selectNurseById(nurseId);
      selectedNurseId.value = nurse.id ?? '';
      print(selectedNurseId.value);
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Error selecting nurse: $e');
      Get.snackbar('Error', 'Failed to select nurse');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectDate(DateTime date) async {
    selectedDate.value = date;
    selectedTime.value = null;
    await loadAvailableSlots();
  }

  void selectTime(DateTime time) {
    selectedTime.value = time;
  }

  Future<void> loadAvailableSlots() async {
    if (selectedDate.value == null) return;

    try {
      isLoading.value = true;
      availableSlots.value = await _appointmentRepository.getAvailableSlots(
        nurseId ?? '',
        selectedDate.value!,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load available slots');
    } finally {
      isLoading.value = false;
    }
  }

  bool canBookAppointment() {
    return selectedDate.value != null &&
        selectedTime.value != null;
  }

  Future<void> bookAppointment() async {
    if (!canBookAppointment()) {
      Get.snackbar('Error', 'Please select a date and time');
      return;
    }

    try {
      isLoading.value = true;
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser == null) {
        Get.snackbar('Error', 'User not found');
        return;
      }

      final appointment = AppointmentEntity(
        id: 0,
        userId: currentUser.id,
        workerId: nurseId,
        time: DateTime(
          selectedDate.value!.year,
          selectedDate.value!.month,
          selectedDate.value!.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute,
        ),
        hours: 1,
      );

      await _appointmentRepository.createAppointment(appointment);
      Get.snackbar('Success', 'Appointment booked successfully');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
