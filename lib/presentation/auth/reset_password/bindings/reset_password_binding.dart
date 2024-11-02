import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'package:dycare/presentation/auth/reset_password/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // First ensure AuthRepository is available
    if (!Get.isRegistered<AuthRepository>()) {
      Get.put(AuthRepository());
    }
    
    // Then register the controller
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
  }
}