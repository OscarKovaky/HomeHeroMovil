import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

abstract class ApiService<T extends JsonSerializable> {
  final String endpoint;

  ApiService(this.endpoint);

  String get apiUrl => '${Config.baseUrl}/$endpoint';

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);

  Future<List<T>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => fromJson(data)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<T> create(T item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode == 201) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<T> update(int id, T item) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode == 200) {
      return fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }
}

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}
