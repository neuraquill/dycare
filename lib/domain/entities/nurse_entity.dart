// lib/domain/entities/nurse_entity.dart

class NurseEntity {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final String? profilePicture;
  final List<String> availableDays;

  NurseEntity({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    this.profilePicture,
    required this.availableDays,
  });

  factory NurseEntity.fromJson(Map<String, dynamic> json) {
    return NurseEntity(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      rating: json['rating'].toDouble(),
      profilePicture: json['profilePicture'],
      availableDays: List<String>.from(json['availableDays']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'rating': rating,
      'profilePicture': profilePicture,
      'availableDays': availableDays,
    };
  }
}