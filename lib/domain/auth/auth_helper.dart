// lib/domain/auth/auth_helper.dart

import 'package:dycare/domain/entities/user_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AuthHelper {
  static final AuthHelper _instance = AuthHelper._internal();

  factory AuthHelper() {
    return _instance;
  }

  AuthHelper._internal();

  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;

  Future<Map<String, dynamic>> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return {};

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever || 
          permission == LocationPermission.denied) {
        return {};
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, 
        position.longitude
      );

      if (placemarks.isEmpty) return {};

      Placemark place = placemarks[0];
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'street': place.street ?? '',
        'city': place.locality ?? '',
        'country': place.country ?? '',
      };
    } catch (e) {
      return {};
    }
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    Map<String, dynamic> location = await _getCurrentLocation();

    if (email == 'patient@example.com' && password == 'password123') {
      _currentUser = UserEntity(
        id: '1',
        name: 'John Doe',
        age: 30,
        location: location,
        phone: '+1234567890',
        role: UserRole.patient,
      );
      return true;
    } else if (email == 'nurse@example.com' && password == 'password123') {
      _currentUser = UserEntity(
        id: '2',
        name: 'Jane Smith',
        age: 35,
        location: location,
        phone: '+9876543210',
        role: UserRole.nurse,
      );
      return true;
    }

    return false;
  }

  Future<bool> register(String name, String email, String password, UserRole role) async {
    await Future.delayed(Duration(seconds: 2));

    Map<String, dynamic> location = await _getCurrentLocation();

    _currentUser = UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      age: 25, // Default age, can be updated later
      location: location,
      phone: '', // Can be updated later
      role: role,
    );

    return true;
  }

  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    _currentUser = null;
  }

  bool isLoggedIn() {
    return _currentUser != null;
  }

  Future<bool> resetPassword(String email) async {
    await Future.delayed(Duration(seconds: 2));
    return email.contains('@');
  }
}