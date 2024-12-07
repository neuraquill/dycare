import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/search_repository.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BookAppointmentController extends GetxController {
  final AppointmentRepository _appointmentRepository;
  final UserRepository _userRepository;
  final SearchRepository _searchRepository;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
  final RxString selectedShift = ''.obs; // New shift selection state

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void setNurseId(String id) {
    nurseId = id;
    selectedDate.value = null;
    selectedTime.value = null;
    selectedShift.value = ''; // Reset shift selection
    availableSlots.clear();
    loadAvailableSlots();
  }

  void selectShift(String shift) {
    selectedShift.value = shift;
  }

  Future<void> selectNurseById(String nurseId) async {
    if (nurseId.isEmpty) {
      Get.snackbar('Error', 'Nurse ID is not available');
      return;
    }
    isLoading.value = true;
    try {
      NurseEntity nurse = await _searchRepository.selectNurseById(nurseId);
      selectedNurseId.value = nurse.id ?? '';
    } catch (e) {
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
    return selectedDate.value != null && selectedShift.value.isNotEmpty;
  }

  Future<void> bookAppointment() async {
    if (!canBookAppointment()) {
      Get.snackbar('Error', 'Please select a date and shift');
      return;
    }

    try {
      isLoading.value = true;
      final currentUser = await _userRepository.getCurrentUser();
      if (currentUser == null) {
        Get.snackbar('Error', 'User not found');
        return;
      }

      // Determine hours based on selected shift
      int hours = selectedShift.value == 'Full' ? 24 : 12;

      final appointment = AppointmentEntity(
        userId: currentUser.id,
        workerId: nurseId,
        time: DateTime(
          selectedDate.value!.year,
          selectedDate.value!.month,
          selectedDate.value!.day,
        ),
        hours: hours,
        id: 0,
      );

      final responseMessage = await _appointmentRepository.createAppointment(appointment);
      
      if (responseMessage == 'Appointment booked successfully') {
        _showNotification('Appointment booked', responseMessage);
        Get.back();
      } else {
        Get.snackbar('Error', responseMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to book appointment: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _showNotification(String title, String message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'appointment_channel',
      'Appointment Notifications',
      channelDescription: 'Notifications for appointment status',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      notificationDetails,
    );
  }
}