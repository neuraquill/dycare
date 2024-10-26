// lib/presentation/auth/reset_password/bindings/reset_password_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/auth/reset_password/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}