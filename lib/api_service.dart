import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String _baseUrl = 'https://llmcookingai2-b0c112716675.herokuapp.com/';

  // Headers are defined as a member variable of the class
  final Map<String, String> _headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  // Method for fetching recipe based on a search query
  Future<Map<String, dynamic>> fetchRecipeFromSearch(String query) async {
    final uri = Uri.parse('$_baseUrl/recipe/from_search');
    final response = await http.post(
      uri,
      headers: _headers,
      body: {
        'search_query': query,
      },
    );
    return _processResponse(response);
  }

  // Method for fetching a random recipe
  Future<Map<String, dynamic>> fetchRandomRecipe() async {
    final uri = Uri.parse('$_baseUrl/recipe/random');
    final response = await http.get(uri, headers: _headers);
    return _processResponse(response);
  }

  // Common method to process the HTTP response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        // Attempt to decode the response body to a Map
        return json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        // If decoding fails, throw a more descriptive error
        throw Exception("Failed to parse recipe data");
      }
    } else {
      // If the status code is not 200, throw an error with the status code
      throw Exception("Failed to load recipe data: ${response.statusCode}");
    }
  }

   Future<Map<String, dynamic>> fetchRecipeFromImage(File image) async {
    final uri = Uri.parse('$_baseUrl/recipe/from_image');
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(_headers)
      ..files.add(await http.MultipartFile.fromPath(
        'image', 
        image.path,
        contentType: MediaType('image', 'png'), // You can change the subtype based on your image type
      ));

    // Send the request
    var streamedResponse = await request.send();

    // Get the response from the stream
    var response = await http.Response.fromStream(streamedResponse);
    return _processResponse(response);
  }
}

