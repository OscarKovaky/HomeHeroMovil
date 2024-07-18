// lib/views/item_form.dart
// lib/views/post_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/models/post.dart';

class PostForm extends StatefulWidget {
  final Post? post;

  PostForm({this.post});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final ApiService apiService = ApiService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.post == null) {
                  apiService.createPost(
                    titleController.text,
                    bodyController.text,
                  ).then((_) {
                    Navigator.of(context).pop(true);
                  });
                } else {
                  apiService.updatePost(
                    widget.post!.id,
                    titleController.text,
                    bodyController.text,
                  ).then((_) {
                    Navigator.of(context).pop(true);
                  });
                }
              },
              child: Text(widget.post == null ? 'Create' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}