// lib/presentation/auth/forgot_password/bindings/forgot_password_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/auth/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}