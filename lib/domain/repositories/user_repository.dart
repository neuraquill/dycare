// lib/domain/repositories/user_repository.dart
import 'dart:io';
import 'package:dycare/domain/entities/user_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity?> getUserByPhone(String phone);
  Future<UserEntity> updateUser(UserEntity user);
  Future<String> updateProfilePicture(File image);
  Future<void> deleteUser(String userId);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> loginWithPhone(String phone);
  Future<UserEntity> register(UserEntity user);
  Future<List<UserEntity>> searchUsers(String query);
}

class UserRepositoryImpl implements UserRepository {
  final String baseUrl = 'https://hono-on-vercel-swart-one.vercel.app/api'; // Update with your actual backend URL

  @override
  Future<UserEntity?> getUserByPhone(String phone) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/register/phone/$phone'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        print("User number verification response data: $data");

        // Ensure that the data conforms to the expected structure
        if (data != null) {
          return UserEntity.fromJson({
            ...data,
            'location': data['location'] ?? {}, // Ensure location is a Map
          });
        }
        return null;
      }
      return null;
    } catch (e) {
      print('Error getting user by phone: $e');
      return null;
    }
  }

  @override
  Future<UserEntity?> loginWithPhone(String phone) async {
    return await getUserByPhone(phone);
  }

  @override
  Future<UserEntity> register(UserEntity user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': user.name,
          'age': user.age,
          'location': {
            'latitude': user.latitude,
            'longitude': user.longitude,
          },
          'phone': user.phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        return UserEntity.fromJson({
          ...user.toJson(),
          'id': data['userID'], // Assuming userID is returned as part of data
        });
      }
      throw Exception('Registration failed');
    } catch (e) {
      print('Error registering user: $e');
      rethrow;
    }
  }

  // Implement other methods with placeholder or mock implementations
  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('current_user');
      if (userJson != null) {
        final userMap = json.decode(userJson);
        return UserEntity.fromJson(userMap);  // Convert JSON back to UserEntity
      }
      return null;
    } catch (e) {
      print('Error retrieving current user: $e');
      return null;
    }
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async => user;

  @override
  Future<String> updateProfilePicture(File image) async => '';

  @override
  Future<void> deleteUser(String userId) async {}

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user');  // Clear the stored user data
  }

  @override
  Future<bool> isLoggedIn() async => false;

  @override
  Future<List<UserEntity>> searchUsers(String query) async => [];
}
