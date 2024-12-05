import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class MyAppointmentsController extends GetxController {
  final AppointmentRepository _appointmentRepository = Get.find();
  final UserRepository _userRepository = Get.find();

  final RxList<AppointmentEntity> appointments = <AppointmentEntity>[].obs;
  final RxBool isLoading = true.obs;
  final RxMap<String, String> nurseNames = <String, String>{}.obs;

  // New variables for filtering
  final RxList<AppointmentEntity> filteredAppointments = <AppointmentEntity>[].obs;
  final RxString selectedStatus = 'Upcoming'.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future loadAppointments() async {
    try {
      isLoading.value = true;
      await _loadNurseNames();
      applyFilters(); // Apply filters initially
    } catch (e) {
      Get.snackbar('Error', 'Failed to load appointments');
    } finally {
      isLoading.value = false;
    }
  }

  Future _loadNurseNames() async {
    try {
      // For dummy data, we'll use predefined nurse names
      final predefinedNurseNames = {
        'nurse1': 'Dr. Emily Smith',
        'nurse2': 'Dr. Michael Johnson',
        'nurse3': 'Dr. Sarah Williams',
        'nurse4': 'Dr. David Brown',
        'nurse5': 'Dr. Lisa Taylor',
        'nurse6': 'Dr. Robert Davis',
        'nurse7': 'Dr. Jennifer Lee',
        'nurse8': 'Dr. Christopher Wilson',
        'nurse9': 'Dr. Amanda Martinez',
        'nurse10': 'Dr. Daniel Anderson',
        'nurse11': 'Dr. Rachel Thompson',
        'nurse12': 'Dr. Kevin Rodriguez',
      };

      nurseNames.value = predefinedNurseNames;
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
      final matchesStatus = selectedStatus.isEmpty;
      final matchesDate = selectedDate.value == null ||
          appointment.time.toLocal().isAtSameMomentAs(selectedDate.value!);
      return matchesStatus && matchesDate;
    }).toList();
  }

  getFilteredAppointments(String status) {}
}