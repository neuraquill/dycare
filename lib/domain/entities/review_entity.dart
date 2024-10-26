// lib/domain/entities/review_entity.dart

class ReviewEntity {
  final String id;
  final String nurseId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;
  final DateTime? updatedAt;

  String patientName;

  DateTime date;

  ReviewEntity({
    required this.id,
    required this.nurseId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.updatedAt,
    required this.patientName,
    required this.date,
  });

  // You might want to add methods like copyWith, toJson, fromJson here
}