// lib/domain/entities/user_entity.dart

enum UserRole { patient, nurse, admin }

class UserEntity {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String? profilePicture;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.profilePicture,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${json['role']}'),
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.toString().split('.').last,
      'profilePicture': profilePicture,
    };
  }
}