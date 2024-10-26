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
}