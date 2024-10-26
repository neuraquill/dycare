// lib/presentation/appointments/book_appointment/controller/book_appointment_controller.dart

import 'package:get/get.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class BookAppointmentController extends GetxController {
  final AppointmentRepository _appointmentRepository;
  final NurseRepository _nurseRepository;
  final UserRepository _userRepository;

  BookAppointmentController(
    this._appointmentRepository,
    this._nurseRepository,
    this._userRepository,
  );

  final Rx<NurseEntity?> selectedNurse = Rx<NurseEntity?>(null);
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedTime = Rx<DateTime?>(null);
  final RxList<DateTime> availableSlots = <DateTime>[].obs;
  final RxBool isLoading = false.obs;

  void selectNurse(NurseEntity nurse) {
    selectedNurse.value = nurse;
    selectedDate.value = null;
    selectedTime.value = null;
    availableSlots.clear();
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
    if (selectedNurse.value == null || selectedDate.value == null) return;

    try {
      isLoading.value = true;
      availableSlots.value = await _appointmentRepository.getAvailableSlots(
        selectedNurse.value!.id,
        selectedDate.value!,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load available slots');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookAppointment() async {
    if (selectedNurse.value == null || selectedDate.value == null || selectedTime.value == null) {
      Get.snackbar('Error', 'Please select a nurse, date, and time');
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
        id: '', // This will be assigned by the backend
        patientId: currentUser.id,
        nurseId: selectedNurse.value!.id,
        dateTime: DateTime(
          selectedDate.value!.year,
          selectedDate.value!.month,
          selectedDate.value!.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute,
        ),
        status: 'Scheduled',
      );

      await _appointmentRepository.createAppointment(appointment);
      Get.snackbar('Success', 'Appointment booked successfully');
      Get.back(); // Navigate back to previous screen
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment');
    } finally {
      isLoading.value = false;
    }
  }
}