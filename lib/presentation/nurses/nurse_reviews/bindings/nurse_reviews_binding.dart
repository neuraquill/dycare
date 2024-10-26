// lib/presentation/nurses/nurse_reviews/bindings/nurse_reviews_binding.dart

import 'package:get/get.dart';
import 'package:dycare/presentation/nurses/nurse_reviews/controller/nurse_reviews_controller.dart';

class NurseReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NurseReviewsController());
  }
}