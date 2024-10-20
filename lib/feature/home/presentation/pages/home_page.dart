import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/feature/home/presentation/manager/post_provider.dart';

import 'post_detail_page.dart';
import 'post_form_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              postProvider.fetchPosts();
            },
          ),
        ],
      ),
      body: _buildBody(context, postProvider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PostFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PostProvider postProvider) {
    if (postProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (postProvider.hasError) {
      return const Center(child: Text('Error loading posts'));
    } else if (postProvider.posts.isEmpty) {
      return const Center(child: Text('No posts available'));
    } else {
      return ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          final post = postProvider.posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            onTap: () {
              postProvider.fetchPostById(post.id);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(postId: post.id),
                ),
              );
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await postProvider.removePost(post.id);
              },
            ),
          );
        },
      );
    }
  }
}
