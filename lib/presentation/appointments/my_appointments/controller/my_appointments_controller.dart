// lib/presentation/appointments/my_appointments/controller/my_appointments_controller.dart

import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class MyAppointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find<AppointmentRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  final RxList<AppointmentEntity> appointments = <AppointmentEntity>[].obs;
  final RxBool isLoading = true.obs;
  final RxMap<String, String> nurseNames = <String, String>{}.obs;

  // New variables for filtering
  final RxList<AppointmentEntity> filteredAppointments = <AppointmentEntity>[].obs;
  final RxString selectedStatus = ''.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    try {
      isLoading.value = true;
      final userId = _userRepository.getCurrentUser();
      appointments.value = await _appointmentRepository.getAppointmentsByUserId(userId as String);
      await _loadNurseNames();
      applyFilters(); // Apply filters initially
    } catch (e) {
      Get.snackbar('Error', 'Failed to load appointments');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadNurseNames() async {
    try {
      for (var appointment in appointments) {
        if (!nurseNames.containsKey(appointment.nurseId)) {
          final nurse = await _userRepository.getUserById(appointment.nurseId);
          nurseNames[appointment.nurseId] = nurse?.name ?? 'Unknown Nurse';
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load nurse names');
    }
  }

  String getNurseName(String nurseId) {
    return nurseNames[nurseId] ?? 'Unknown Nurse';
  }

  void refreshAppointments() {
    loadAppointments();
  }

  // New methods for filtering
  void setSelectedStatus(String status) {
    selectedStatus.value = status;
    applyFilters();
  }

  void setSelectedDate(DateTime? date) {
    selectedDate.value = date;
    applyFilters();
  }

  void applyFilters() {
    filteredAppointments.value = appointments.where((appointment) {
      final matchesStatus = selectedStatus.isEmpty || appointment.status == selectedStatus.value;
      final matchesDate = selectedDate.value == null || 
                          appointment.dateTime.toLocal().isAtSameMomentAs(selectedDate.value!);
      return matchesStatus && matchesDate;
    }).toList();
  }
}
