import 'package:get/get.dart';
import 'package:dycare/presentation/profile/view_profile/controller/view_profile_controller.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';

class ViewProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Inject repositories if they haven't been injected yet
    if (!Get.isRegistered<UserRepository>()) {
      Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    }
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => AppointmentRepositoryImpl('http://192.168.29.9:3000'));
    }

    // Inject the ProfileController
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        Get.find<UserRepository>(),
        Get.find<AppointmentRepository>(),
      ),
    );
  }
}