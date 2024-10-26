// lib/presentation/nurses/nurse_details/bindings/nurse_details_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/nurses/nurse_details/controller/nurse_details_controller.dart';

class NurseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NurseDetailsController());
  }
}