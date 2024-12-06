import 'package:dycare/domain/entities/nurse_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SearchRepository {
  Future<List<NurseEntity>> getAllSearchResults();
}

class SearchRepositoryImpl implements SearchRepository {
  final String baseUrl = 'https://hono-on-vercel-swart-one.vercel.app/api/api/list'; // Replace with actual base URL

  @override
  Future<List<NurseEntity>> getAllSearchResults() async {
    final endpoints = ['nurses', 'physiotherapist', 'caretakers']; // Add more endpoints as needed
    List<NurseEntity> allResults = [];

    for (String endpoint in endpoints) {
      final uri = Uri.parse('$baseUrl/$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final List<NurseEntity> results =
            data.map((json) => NurseEntity.fromJson(json)).toList();
        allResults.addAll(results);
      } else {
        throw Exception('Failed to fetch data from $endpoint');
      }
    }

    return allResults;
  }
}
