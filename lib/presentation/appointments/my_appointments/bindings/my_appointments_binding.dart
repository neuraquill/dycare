// lib/presentation/appointments/my_appointments/bindings/my_appointments_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/my_appointments/controller/my_appointments_controller.dart';

class MyAppointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAppointmentsController());
  }
}