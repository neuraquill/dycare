// lib/presentation/auth/signup/bindings/signup_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/auth/signup/controller/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}