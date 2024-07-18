// lib/services/api_service.dart
// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/config.dart';

class ApiService {
  final String apiUrl = Config.apiUrl;

  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> createPost(String title, String body) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'body': body}),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Post> updatePost(int id, String title, String body) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'body': body}),
    );

    if (response.statusCode == 204) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete post');
    }
  }
}
