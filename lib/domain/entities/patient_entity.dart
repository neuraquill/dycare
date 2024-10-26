// lib/domain/entities/patient_entity.dart

class PatientEntity {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime dateOfBirth;
  final String? medicalHistory;

  PatientEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.dateOfBirth,
    this.medicalHistory,
  });

  factory PatientEntity.fromJson(Map<String, dynamic> json) {
    return PatientEntity(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      medicalHistory: json['medicalHistory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'medicalHistory': medicalHistory,
    };
  }
}