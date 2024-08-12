import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/feature/home/presentation/manager/post_provider.dart';

import 'post_form_page.dart';

class PostDetailPage extends StatelessWidget {
  final int postId;

  PostDetailPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostFormPage(post: postProvider.post),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: postProvider.fetchPostById(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading post details'));
          } else {
            final post = postProvider.post;
            return post != null
                ? Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(post.body),
                ],
              ),
            )
                : Center(child: Text('Post not found'));
          }
        },
      ),
    );
  }
}
