// lib/presentation/appointments/appointment_details/bindings/appointment_details_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/appointments/appointment_details/controller/appointment_details_controller.dart';

class AppointmentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppointmentDetailsController());
  }
}