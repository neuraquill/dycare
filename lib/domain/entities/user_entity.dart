// lib/domain/entities/user_entity.dart
enum UserRole { patient, nurse, admin }

class UserEntity {
  final String id;
  final String name;
  final int age;
  final Map location;
  final String phone;
  final UserRole role;
  final String? profilePicture;

  // Convenience getters for latitude and longitude
  double get latitude => location['latitude'] ?? 0.0;
  double get longitude => location['longitude'] ?? 0.0;

  UserEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.phone,
    this.role = UserRole.patient,
    this.profilePicture,
  });

  factory UserEntity.fromJson(Map json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      location: json['location'] ?? {},
      phone: json['phone'].toString(), // Convert phone to a string.
      role: json['role'] != null 
        ? UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${json['role']}') 
        : UserRole.patient,
      profilePicture: json['profilePicture'],
    );
  }


  Map toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'location': location,
      'phone': phone,
      'role': role.toString().split('.').last,
      'profilePicture': profilePicture,
    };
  }

  UserEntity copyWith({
    String? name,
    int? age,
    Map? location,
    String? phone,
    String? profilePicture,
  }) {
    return UserEntity(
      id: this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      role: this.role,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}