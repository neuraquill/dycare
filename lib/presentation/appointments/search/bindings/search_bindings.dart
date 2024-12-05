// lib/presentation/appointments/search/controller/search_controller.dart

import 'package:dycare/presentation/appointments/search/controller/search_controller.dart';
import 'package:dycare/domain/repositories/search_repository.dart';
import 'package:get/get.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    // Bind the SearchRepositoryImpl
    Get.lazyPut<SearchRepository>(() => SearchRepositoryImpl());

    // Bind the SearchController and inject the SearchRepository
    Get.lazyPut<SearchController>(
      () => SearchController(Get.find<SearchRepository>()),
    );
  }
}
