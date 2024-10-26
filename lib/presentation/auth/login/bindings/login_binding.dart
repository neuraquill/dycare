// lib/presentation/auth/login/binding/login_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/auth/login/controller/login_controller.dart';
import 'package:dycare/domain/repositories/user_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Inject the UserRepository if it hasn't been injected yet
    if (!Get.isRegistered<UserRepository>()) {
      Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    }

    // Inject the LoginController
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<UserRepository>()),
    );
  }
}