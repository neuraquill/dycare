// lib/domain/entities/nurse_entity.dart

class NurseEntity {
  final String id;
  final String name;
  final int? age;
  final int? yearsOfExp;
  final String? type;
  final String? profilePicture;  // Added profilePicture field
  final String? specialization;  // Added specialization field
  final double? rating;  // Added rating field
  final List<String> availableDays;  // Added availableDays field

  NurseEntity({
    required this.id,
    required this.name,
    this.age,
    this.yearsOfExp,
    this.type,
    this.profilePicture,
    this.specialization,
    this.rating,
    required this.availableDays,
  });

  // A factory constructor to create a NurseEntity from JSON
  factory NurseEntity.fromJson(Map<String, dynamic> json) {
    return NurseEntity(
      id: json['id'].toString(),
      name: json['name'],
      age: json['age'],
      yearsOfExp: json['years_of_exp'],
      type: json['type'],
      profilePicture: json['profile_picture'],
      specialization: json['specialization'],
      rating: json['rating'],
      availableDays: List<String>.from(json['available_days'] ?? []),
    );
  }

  // Convert a NurseEntity to JSON format for database use
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'years_of_exp': yearsOfExp,
      'type': type,
      'profile_picture': profilePicture,
      'specialization': specialization,
      'rating': rating,
      'available_days': availableDays,
    };
  }
}
