// lib/presentation/auth/otp/bindings/otp_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/auth/otp/controller/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}