// lib/presentation/profile/edit_profile/bindings/edit_profile_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/profile/edit_profile/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileController());
  }
}