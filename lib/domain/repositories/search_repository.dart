// TODO Implement this library.// lib/domain/repositories/search_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dycare/domain/entities/nurse_entity.dart';

abstract class SearchRepository {
  Future<List<NurseEntity>> getAllItems(String type);
  Future<NurseEntity> selectNurseById(String id);
  
}

class SearchRepositoryImpl extends SearchRepository {
  final String baseUrl = 'https://hono-on-vercel-swart-one.vercel.app/api';

  @override
  Future<List<NurseEntity>> getAllItems(String type) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/list/$type'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'columns': ['id', 'name', 'age', 'years_of_exp', 'education', 'profile_picture', 'rating', 'specialization', 'schedule']
        }),
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final List<dynamic> data = responseBody['data'];
        return data.map((item) => NurseEntity.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items: ${response.body}');
      }
    } catch (e) {
      print('Error in getAllItems: $e');
      throw Exception('Failed to load items: $e');
    }
  }

  Future<NurseEntity> selectNurseById(String nurseId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/list/nurse/$nurseId'),  // Assuming the endpoint for fetching a nurse by ID
        headers: {'Content-Type': 'application/json'},
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final data = responseBody['data'];
        return NurseEntity.fromJson(data);  // Returning a single NurseEntity
      } else {
        throw Exception('Failed to load nurse: ${response.body}');
      }
    } catch (e) {
      print('Error in selectNurseById: $e');
      throw Exception('Failed to load nurse: $e');
    }
  }

}
