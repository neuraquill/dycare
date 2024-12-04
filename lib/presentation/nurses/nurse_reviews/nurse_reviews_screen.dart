// lib/presentation/nurses/nurse_reviews/nurse_reviews_screen.dart

import 'package:dycare/theme/custom_text_style.dart' as customTheme;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/nurses/nurse_reviews/controller/nurse_reviews_controller.dart';
import 'package:dycare/domain/entities/review_entity.dart';

class NurseReviewsScreen extends GetWidget<NurseReviewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nurse Reviews'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.reviews.isEmpty) {
          return Center(child: Text('No reviews yet'));
        } else {
          return Column(
            children: [
              _buildOverallRating(),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewCard(controller.reviews[index]);
                  },
                ),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addReview(),
        child: Icon(Icons.add),
        tooltip: 'Add Review',
      ),
    );
  }

  Widget _buildOverallRating() {
    return Container(
      padding: EdgeInsets.all(16),
      color: AppColors.primary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Overall Rating: ',
            style: customTheme.CustomTextStyle.titleMedium(),
          ),
          Text(
            '${controller.overallRating.toStringAsFixed(1)}',
            style: CustomTextStyle.headlineMedium(color: AppColors.primary),
          ),
          Icon(Icons.star, color: Colors.amber),
          Text(
            ' (${controller.reviews.length} reviews)',
            style: CustomTextStyle.bodyMedium(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewEntity review) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.patientName,
                  style: CustomTextStyle.titleMedium(),
                ),
                Row(
                  children: [
                    Text(
                      review.rating.toString(),
                      style: CustomTextStyle.titleMedium(color: Colors.amber),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              review.comment,
              style: CustomTextStyle.bodyMedium(),
            ),
            SizedBox(height: 8),
            Text(
              DateTimeUtils.formatDate(review.date),
              style: CustomTextStyle.bodySmall(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}