// lib/domain/auth/auth_repository.dart

import 'package:dycare/domain/auth/auth_helper.dart';
import 'package:dycare/domain/entities/user_entity.dart';

class AuthRepository {
  final AuthHelper _authHelper = AuthHelper();

  Future<bool> login(String email, String password) async {
    return await _authHelper.login(email, password);
  }

  Future<bool> register(String name, String email, String password, UserRole role) async {
    return await _authHelper.register(name, email, password, role);
  }

  Future<void> logout() async {
    await _authHelper.logout();
  }

  bool isLoggedIn() {
    return _authHelper.isLoggedIn();
  }

  UserEntity? getCurrentUser() {
    return _authHelper.currentUser;
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    return await _authHelper.resetPassword(email);
  }

  // New methods for OTP and user name registration
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    return await _authHelper.verifyOTP(phoneNumber, otp);
  }

  Future<bool> sendOTP(String phoneNumber) async {
    return await _authHelper.sendOTP(phoneNumber);
  }

  Future<bool> isNewUser(String phoneNumber) async {
    return await _authHelper.isNewUser(phoneNumber);
  }

  Future<bool> updateUserName(String fullName) async {
    return await _authHelper.updateUserName(fullName);
  }

  // Optional: Method to get the verified phone number after OTP verification
  String? getVerifiedPhoneNumber() {
    return _authHelper.verifiedPhoneNumber;
  }
}

// You'll also need to update the AuthHelper class to support these new methods:

// lib/domain/auth/auth_helper.dart

class AuthHelper {
  UserEntity? currentUser;
  String? verifiedPhoneNumber;

  Future<bool> login(String email, String password) async {
    // Existing implementation
    throw UnimplementedError();
  }

  Future<bool> register(String name, String email, String password, UserRole role) async {
    // Existing implementation
    throw UnimplementedError();
  }

  Future<void> logout() async {
    // Existing implementation
    currentUser = null;
    verifiedPhoneNumber = null;
  }

  bool isLoggedIn() {
    return currentUser != null;
  }

  Future<bool> resetPassword(String email) async {
    // Existing implementation
    throw UnimplementedError();
  }

  // New methods implementation
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      // Implement your OTP verification logic here
      // This could involve calling a backend API or Firebase Auth
      
      // If verification is successful, store the phone number
      verifiedPhoneNumber = phoneNumber;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendOTP(String phoneNumber) async {
    try {
      // Implement your OTP sending logic here
      // This could involve calling a backend API or Firebase Auth
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isNewUser(String phoneNumber) async {
    try {
      // Check if the user exists in your backend/database
      // Return true if the user is new, false if they already exist
      return true; // Placeholder return
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserName(String fullName) async {
    try {
      // Implement the logic to update the user's name
      // This could involve:
      // 1. Creating a new user if they don't exist
      // 2. Updating an existing user's name
      // 3. Storing the user information locally
      
      // Create or update the current user
      currentUser = UserEntity(
        id: 'generated_id', // Generate or get from backend
        name: fullName,
        phoneNumber: verifiedPhoneNumber ?? '',
        role: UserRole.patient, // Default role, adjust as needed
      );
      
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Update or create the UserEntity class if needed:
// lib/domain/entities/user_entity.dart

enum UserRole {
  patient,
  doctor,
  admin
}

class UserEntity {
  final String id;
  final String name;
  final String phoneNumber;
  final UserRole role;
  
  UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
  });
  
  // Add toJson and fromJson methods if needed for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role.toString(),
    };
  }
  
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString() == json['role'],
        orElse: () => UserRole.patient,
      ),
    );
  }
}