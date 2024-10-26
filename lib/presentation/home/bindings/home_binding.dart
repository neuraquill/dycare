import 'package:get/get.dart';
import 'package:dycare/presentation/home/controller/home_controller.dart';
import 'package:dycare/domain/repositories/user_repository.dart';
import 'package:dycare/domain/repositories/appointment_repository.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Inject repositories if they haven't been injected yet
    if (!Get.isRegistered<UserRepository>()) {
      Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    }
    if (!Get.isRegistered<AppointmentRepository>()) {
      Get.lazyPut<AppointmentRepository>(() => AppointmentRepositoryImpl());
    }
    if (!Get.isRegistered<NurseRepository>()) {
      Get.lazyPut<NurseRepository>(() => NurseRepositoryImpl());
    }

    // Inject the HomeController
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<UserRepository>(),
        Get.find<AppointmentRepository>(),
        Get.find<NurseRepository>(),
      ),
    );
  }
}