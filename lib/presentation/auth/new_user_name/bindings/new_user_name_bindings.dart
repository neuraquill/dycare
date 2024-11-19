// lib/presentation/auth/new_user_name/bindings/new_user_name_binding.dart

import 'package:get/get.dart';
import 'package:dycare/domain/auth/auth_repository.dart';
import 'package:dycare/presentation/auth/new_user_name/controller/new_user_name_controller.dart';

class NewUserNameBinding extends Bindings {
  @override
  void dependencies() {
    // First ensure AuthRepository is available
    if (!Get.isRegistered<AuthRepository>()) {
      Get.put(AuthRepository());
    }
    
    // Then register the controller
    Get.lazyPut<NewUserNameController>(
      () => NewUserNameController(),
    );
  }
}

// Keep the existing AuthTextField and ResponsiveFontSizes classes from your original code,
// but add this new parameter to AuthTextField:
