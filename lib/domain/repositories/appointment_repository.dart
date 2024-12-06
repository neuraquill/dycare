//appointments_repository.dart
import 'dart:convert';
import 'package:dycare/domain/entities/appointment_entity.dart';
import 'package:http/http.dart' as http;

abstract class AppointmentRepository {
  Future<List<AppointmentEntity>> getAppointmentsByUserId(String userId);
  Future<String> createAppointment(AppointmentEntity appointment); // Changed return type to String for status
  Future<List<DateTime>> getAvailableSlots(String workerId, DateTime date);
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final String baseUrl;

  AppointmentRepositoryImpl(this.baseUrl);

  @override
  Future<List<AppointmentEntity>> getAppointmentsByUserId(String userId) async {
    final response = await _get('/appointment?userId=$userId');
    return (response as List)
        .map((json) => AppointmentEntity.fromJson(json))
        .toList();
  }

  @override
  Future<String> createAppointment(AppointmentEntity appointment) async {
    print('Creating appointment: ${appointment.toJson()}');
    final response = await _post(
      '/appointments/book',
      body: appointment.toJson(),
    );
    print("Book Appointment response: $response");

    if (response['status'] == 200) {
      // If the status is 200, it means the appointment was successfully booked.
      return 'Appointment booked successfully';
    } else {
      // If status is not 200, return the message indicating the failure.
      return response['message'] ?? 'Unknown error occurred';
    }
  }

  @override
  Future<List<DateTime>> getAvailableSlots(String workerId, DateTime date) async {
    // Returning an empty list for now
    return [];
  }

  // Helper methods to handle GET and POST requests
  Future<Map<String, dynamic>> _get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> _post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create appointment: ${response.statusCode}');
    }
  }
}
