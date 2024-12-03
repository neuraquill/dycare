import 'package:dycare/theme/custom_text_style.dart' as customTheme;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dycare/core/utils/app_export.dart';
import 'package:dycare/presentation/nurses/nurse_reviews/controller/nurse_reviews_controller.dart';
import 'package:dycare/domain/entities/review_entity.dart';

class NurseReviewsScreen extends GetWidget<NurseReviewsController> {
  const NurseReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.06;

    final fontSizes = ResponsiveFontSizes(
      tiny: screenHeight * 0.014,
      small: screenHeight * 0.016,
      medium: screenHeight * 0.018,
      large: screenHeight * 0.024,
      xlarge: screenHeight * 0.032,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nurse Reviews', 
          style: TextStyle(fontSize: fontSizes.medium),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.reviews.isEmpty) {
          return Center(
            child: Text(
              'No reviews yet', 
              style: TextStyle(fontSize: fontSizes.medium),
            ),
          );
        } else {
          return Column(
            children: [
              _buildOverallRating(fontSizes, screenWidth),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewCard(
                      controller.reviews[index], 
                      fontSizes, 
                      horizontalPadding,
                      verticalSpacing
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addReview(),
        child: const Icon(Icons.add),
        tooltip: 'Add Review',
      ),
    );
  }

  Widget _buildOverallRating(ResponsiveFontSizes fontSizes, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      color: AppColors.primary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Overall Rating: ',
            style: TextStyle(fontSize: fontSizes.medium),
          ),
          Text(
            '${controller.overallRating.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: fontSizes.large, 
              color: AppColors.primary
            ),
          ),
          Icon(Icons.star, color: Colors.amber),
          Text(
            ' (${controller.reviews.length} reviews)',
            style: TextStyle(fontSize: fontSizes.small),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    ReviewEntity review, 
    ResponsiveFontSizes fontSizes, 
    double horizontalPadding,
    double verticalSpacing
  ) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding, 
        vertical: verticalSpacing * 0.5
      ),
      child: Padding(
        padding: EdgeInsets.all(horizontalPadding * 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.patientName,
                  style: TextStyle(fontSize: fontSizes.medium),
                ),
                Row(
                  children: [
                    Text(
                      review.rating.toString(),
                      style: TextStyle(
                        fontSize: fontSizes.medium, 
                        color: Colors.amber
                      ),
                    ),
                    Icon(Icons.star, color: Colors.amber, size: fontSizes.small * 1.2),
                  ],
                ),
              ],
            ),
            SizedBox(height: verticalSpacing * 0.5),
            Text(
              review.comment,
              style: TextStyle(fontSize: fontSizes.small),
            ),
            SizedBox(height: verticalSpacing * 0.5),
            Text(
              DateTimeUtils.formatDate(review.date),
              style: TextStyle(
                fontSize: fontSizes.tiny, 
                color: AppColors.textSecondary
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveFontSizes {
  final double tiny;
  final double small;
  final double medium;
  final double large;
  final double xlarge;

  ResponsiveFontSizes({
    required this.tiny,
    required this.small,
    required this.medium,
    required this.large,
    required this.xlarge,
  });
}