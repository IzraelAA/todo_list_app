import 'dart:convert';
import 'package:todo_list_app/feature/home/data/data_sources/api_service.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiService apiService;

  PostRepositoryImpl(this.apiService);

  @override
  Future<List<Post>> getPosts() async {
    final response = await apiService.getPosts();
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Post> getPostById(int id) async {
    final response = await apiService.getPostById(id);
    if (response.statusCode == 200) {
      return PostModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<void> createPost(Post post) async {
    final response = await apiService.createPost((post as PostModel).toJson());
    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }

  @override
  Future<void> updatePost(Post post) async {
    final response = await apiService.updatePost(post.id, (post as PostModel).toJson());
    if (response.statusCode != 200) {
      throw Exception('Failed to update post');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    final response = await apiService.deletePost(id);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
