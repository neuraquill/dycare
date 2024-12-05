// TODO Implement this library.// lib/domain/repositories/search_repository.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dycare/domain/entities/nurse_entity.dart';

abstract class SearchRepository {
  Future<List<NurseEntity>> getAllItems(String type);
}

class SearchRepositoryImpl extends SearchRepository {
  final String baseUrl = 'http://192.168.29.9:3000';

  @override
  Future<List<NurseEntity>> getAllItems(String type) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/list/$type'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'columns': ['name', 'age', 'years_of_exp', 'education', 'profile_picture', 'rating', 'specialization', 'schedule']
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
}
