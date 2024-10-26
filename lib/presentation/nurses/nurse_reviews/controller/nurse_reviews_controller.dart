// lib/presentation/nurses/nurse_reviews/controller/nurse_reviews_controller.dart

import 'package:dycare/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:dycare/domain/entities/review_entity.dart';
import 'package:dycare/domain/repositories/review_repository.dart';

class NurseReviewsController extends GetxController {
  final ReviewRepository _reviewRepository = Get.find<ReviewRepository>();

  final RxList<ReviewEntity> reviews = <ReviewEntity>[].obs;
  final RxBool isLoading = true.obs;
  final RxDouble overallRating = 0.0.obs;

  late String nurseId;

  @override
  void onInit() {
    super.onInit();
    nurseId = Get.arguments as String;
    loadReviews();
  }

  Future<void> loadReviews() async {
    try {
      isLoading.value = true;
      reviews.value = await _reviewRepository.getReviewsForNurse(nurseId);
      _calculateOverallRating();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reviews');
    } finally {
      isLoading.value = false;
    }
  }

  void _calculateOverallRating() {
    if (reviews.isEmpty) {
      overallRating.value = 0.0;
    } else {
      double sum = reviews.fold(0, (prev, review) => prev + review.rating);
      overallRating.value = sum / reviews.length;
    }
  }

  void addReview() async {
    final result = await Get.toNamed(Routes.ADD_REVIEW, arguments: nurseId);
    if (result == true) {
      loadReviews();
    }
  }
}