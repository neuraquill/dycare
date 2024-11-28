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
    _initializeDummyAppointments();
    loadAppointments();
  }

  void _initializeDummyAppointments() {
    // Dummy appointments for each status
    final dummyAppointments = [
      // Upcoming Appointments
      AppointmentEntity(
        id: '1',
        nurseId: 'nurse1',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        notes: 'Routine checkup with Dr. Smith',
        patientId: 'patient1',
        status: 'Upcoming',
      ),
      AppointmentEntity(
        id: '2',
        nurseId: 'nurse2',
        dateTime: DateTime.now().add(const Duration(days: 7)),
        notes: 'Annual physical examination',
        patientId: 'patient2',
        status: 'Upcoming',
      ),
      AppointmentEntity(
        id: '3',
        nurseId: 'nurse3',
        dateTime: DateTime.now().add(const Duration(days: 14)),
        notes: 'Follow-up consultation',
        patientId: 'patient3',
        status: 'Upcoming',
      ),
      AppointmentEntity(
        id: '4',
        nurseId: 'nurse4',
        dateTime: DateTime.now().add(const Duration(days: 21)),
        notes: 'Vaccination update',
        patientId: 'patient4',
        status: 'Upcoming',
      ),

      // Completed Appointments
      AppointmentEntity(
        id: '5',
        nurseId: 'nurse5',
        dateTime: DateTime.now().subtract(const Duration(days: 10)),
        notes: 'Regular health screening',
        patientId: 'patient5',
        status: 'Completed',
      ),
      AppointmentEntity(
        id: '6',
        nurseId: 'nurse6',
        dateTime: DateTime.now().subtract(const Duration(days: 20)),
        notes: 'Post-surgery follow-up',
        patientId: 'patient6',
        status: 'Completed',
      ),
      AppointmentEntity(
        id: '7',
        nurseId: 'nurse7',
        dateTime: DateTime.now().subtract(const Duration(days: 30)),
        notes: 'Preventive care consultation',
        patientId: 'patient7',
        status: 'Completed',
      ),
      AppointmentEntity(
        id: '8',
        nurseId: 'nurse8',
        dateTime: DateTime.now().subtract(const Duration(days: 40)),
        notes: 'Comprehensive health assessment',
        patientId: 'patient8',
        status: 'Completed',
      ),

      // Cancelled Appointments
      AppointmentEntity(
        id: '9',
        nurseId: 'nurse9',
        dateTime: DateTime.now().subtract(const Duration(days: 15)),
        notes: 'Cancelled due to scheduling conflict',
        patientId: 'patient9',
        status: 'Cancelled',
      ),
      AppointmentEntity(
        id: '10',
        nurseId: 'nurse10',
        dateTime: DateTime.now().subtract(const Duration(days: 25)),
        notes: 'Patient requested rescheduling',
        patientId: 'patient10',
        status: 'Cancelled',
      ),
      AppointmentEntity(
        id: '11',
        nurseId: 'nurse11',
        dateTime: DateTime.now().subtract(const Duration(days: 35)),
        notes: 'Clinic emergency cancellation',
        patientId: 'patient11',
        status: 'Cancelled',
      ),
      AppointmentEntity(
        id: '12',
        nurseId: 'nurse12',
        dateTime: DateTime.now().subtract(const Duration(days: 45)),
        notes: 'Health facility maintenance',
        patientId: 'patient12',
        status: 'Cancelled',
      ),
    ];

    appointments.value = dummyAppointments;
    // Initial filter to show Upcoming appointments
    setSelectedStatus('Upcoming');
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

  // New method to get filtered appointments based on status
  List<AppointmentEntity> getFilteredAppointments(String status) {
    return appointments.where((appointment) => 
      appointment.status == status).toList();
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