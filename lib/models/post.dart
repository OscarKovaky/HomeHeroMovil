import '../services/api_service.dart';

class Post implements JsonSerializable {
  final int? id;
  final String title;
  final String body;

  Post({this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}
