import 'dart:convert';

class NurseEntity {
  final String? id;
  final String name;
  final int? age;
  final int? yearsOfExp;
  final String? education;
  final String? profilePicture;
  final String? specialization;
  final double? rating;
  final Map<String, dynamic> schedule;
  final String? location;
  final int? phone;

  NurseEntity({
    this.id,
    required this.name,
    this.age,
    this.yearsOfExp,
    this.education,
    this.profilePicture,
    this.specialization,
    this.rating,
    required this.schedule,
    this.location,
    this.phone,
  });

  factory NurseEntity.fromJson(Map<String, dynamic> json) {
    return NurseEntity(
      id: json['id']?.toString(),
      name: json['name'] ?? 'Unknown',
      age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
      yearsOfExp: json['years_of_exp'] != null 
          ? int.tryParse(json['years_of_exp'].toString()) 
          : null,
      education: json['education'],
      profilePicture: json['profile_picture'] ?? json['profile'],
      specialization: json['specialization'] ?? 'No Specialization',
      rating: json['rating'] != null 
          ? double.tryParse(json['rating'].toString()) 
          : 0.0,
      schedule: json['schedule'] is String 
          ? jsonDecode(json['schedule'] ?? '{"available":[]}') 
          : (json['schedule'] ?? {"available":[]}),
      location: json['location'] ?? json['loc']?['address'],
      phone: json['phone'] != null 
          ? int.tryParse(json['phone'].toString()) 
          : null,
    );
  }
}