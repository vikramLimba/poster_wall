import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class PexelsApi {
  static const _baseUrl = 'https://api.pexels.com/v1';
  final String apiKey;

  PexelsApi(this.apiKey);

  Future<List<dynamic>> search(String query, int page) async {
    if (query.trim().isEmpty) {
      return fetchCurated(page);
    }

    if (query.trim().length < 3) return [];

    try {
      final res = await http
          .get(
            Uri.parse('$_baseUrl/search?query=$query&page=$page&per_page=20'),
            headers: {'Authorization': apiKey},
          )
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        return json.decode(res.body)['photos'] ?? [];
      }
      return [];
    } catch (e) {
      log("error at search :: ${e.toString()}");
      return [];
    }
  }

  Future<List<dynamic>> fetchCurated(int page) async {
    try {
      final res = await http.get(
        Uri.parse('$_baseUrl/curated?page=$page&per_page=20'),
        headers: {'Authorization': apiKey},
      );

      if (res.statusCode == 200) {
        return json.decode(res.body)['photos'] ?? [];
      }
      return [];
    } catch (e) {
      log("error at fetch :: ${e.toString()}");

      return [];
    }
  }
}
