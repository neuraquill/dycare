// lib/presentation/nurses/nurse_list/binding/nurse_list_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/nurses/nurse_list/controller/nurse_list_controller.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';

class NurseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NurseRepository>(() => NurseRepositoryImpl());
    
    Get.lazyPut<NurseListController>(
      () => NurseListController(Get.find<NurseRepository>()),
    );
  }
}