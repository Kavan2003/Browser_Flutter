import 'dart:convert';
import 'package:browser/searchModal.dart';
import 'package:http/http.dart' as http;

class CustomSearchService {
  static const String _baseUrl = 'https://www.googleapis.com/customsearch/v1';
  static const String _apiKey = 'AIzaSyBCAoj9-gHD9XJhDtrVnxz-gKPcvsYbAsU';
  static const String _searchEngineId = 'b455315a51e0047c7';

  static Future<List<SearchResult>> search(String query) async {
    final url = '$_baseUrl?key=$_apiKey&cx=$_searchEngineId&q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> searchResults = data['items'];
      print("||" + "$query" + "||" + searchResults.toString());
      return searchResults.map((json) => SearchResult.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results${response.statusCode}');
    }
  }
}
