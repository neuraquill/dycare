// lib/domain/auth/auth_helper.dart

import 'package:dycare/domain/entities/user_entity.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();

  factory AuthHelper() {
    return _instance;
  }

  AuthHelper._internal();

  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Hardcoded login logic
    if (email == 'patient@example.com' && password == 'password123') {
      _currentUser = UserEntity(
        id: '1',
        email: email,
        name: 'John Doe',
        role: UserRole.patient,
      );
      return true;
    } else if (email == 'nurse@example.com' && password == 'password123') {
      _currentUser = UserEntity(
        id: '2',
        email: email,
        name: 'Jane Smith',
        role: UserRole.nurse,
      );
      return true;
    }

    return false;
  }

  Future<bool> register(String name, String email, String password, UserRole role) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Hardcoded registration logic
    // In a real app, you would validate the input and send it to a server
    _currentUser = UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      role: role,
    );

    return true;
  }

  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    _currentUser = null;
  }

  bool isLoggedIn() {
    return _currentUser != null;
  }

  Future<bool> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Hardcoded reset password logic
    // In a real app, this would send a reset password email
    return email.contains('@');
  }
}