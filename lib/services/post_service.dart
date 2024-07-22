import '../models/post.dart';
import 'api_service.dart';

class PostService extends ApiService<Post> {
  PostService() : super('posts');

  @override
  Post fromJson(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Post post) {
    return post.toJson();
  }
}
