import 'package:dycare/presentation/appointments/search/controller/search_controller.dart';
import 'package:dycare/domain/repositories/nurse_repository.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    // Bind the NurseRepository
    Get.lazyPut<NurseRepository>(() => NurseRepositoryImpl());

    // Bind the SearchController and inject the NurseRepository
    Get.lazyPut<SearchController>(
      () => SearchController(Get.find<NurseRepository>()),
    );
  }
}
