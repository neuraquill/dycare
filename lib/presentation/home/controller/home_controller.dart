// lib/presentation/home/controller/home_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';

class HomeController extends GetxController {
  final UserRepository _userRepository;
  final AppointmentRepository _appointmentRepository;

  HomeController(
    this._userRepository,
    this._appointmentRepository,
  );

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);
  final RxList<AppointmentEntity> upcomingAppointments = <AppointmentEntity>[].obs;
  final RxList<NurseEntity> featuredNurses = <NurseEntity>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    try {
      isLoading.value = true;
      await Future.wait([
        loadCurrentUser(),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load home data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCurrentUser() async {
    currentUser.value = await _userRepository.getCurrentUser();
  }
  void navigateToAppointments() {
    Get.toNamed(Routes.MY_APPOINTMENTS);
  }

  void navigateToNurseList() {
    Get.toNamed(Routes.NURSE_LIST);
  }

  void navigateToBookAppointment() {
    Get.toNamed(Routes.BOOK_APPOINTMENT);
  }

  void navigateToProfile() {
    Get.toNamed(Routes.VIEW_PROFILE);
  }

  Future<void> logout() async {
    try {
      await _userRepository.logout();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout');
    }
  }
}