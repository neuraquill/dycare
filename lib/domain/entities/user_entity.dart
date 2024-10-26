// lib/domain/entities/user_entity.dart

// lib/domain/entities/user_entity.dart

enum UserRole { patient, nurse, admin }

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final UserRole role;
  final String? profilePicture;
  final DateTime? dateOfBirth;
  final String? address;

  var specialization;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.profilePicture,
    this.dateOfBirth,
    this.address, String? specialization,
  });

  // You might want to add methods like copyWith, toJson, fromJson here

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${json['role']}'),
      profilePicture: json['profilePicture'],
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.parse(json['dateOfBirth']) : null,
      address: json['address'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString().split('.').last,
      'profilePicture': profilePicture,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
  UserEntity copyWith({
    String? name,
    String? phoneNumber,
    String? address,
  }) {
    return UserEntity(
      id: this.id,
      name: name ?? this.name,
      email: this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      role: this.role,
      profilePicture: this.profilePicture,
);
}
}