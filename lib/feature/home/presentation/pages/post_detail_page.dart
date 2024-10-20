import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/feature/home/presentation/manager/post_provider.dart';

import 'post_form_page.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;

  PostDetailPage({required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Post Detail'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
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
        body: Builder(builder: (c) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (postProvider.hasError) {
            return const Center(child: Text('Error loading post details'));
          } else {
            final post = postProvider.post;
            return post != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(post.body),
                      ],
                    ),
                  )
                : const Center(child: Text('Post not found'));
          }
        }));
  }
}
