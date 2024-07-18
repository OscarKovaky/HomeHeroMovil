// lib/views/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/models/post.dart';
import 'post_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = apiService.getPosts();
  }

  void _refreshPosts() {
    setState(() {
      futurePosts = apiService.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: futurePosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No posts found');
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostForm(post: post)),
                          );
                          if (result == true) {
                            _refreshPosts();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          apiService.deletePost(post.id).then((_) {
                            _refreshPosts();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostForm()),
          );
          if (result == true) {
            _refreshPosts();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


