import 'package:flutter/material.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/create_post.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/delete_post.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/get_post_by_id.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/get_posts.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/update_post.dart';

import '../../domain/entities/post.dart';


class PostProvider with ChangeNotifier {
  final GetPosts getPostsUseCase;
  final GetPostById getPostByIdUseCase;
  final CreatePost createPostUseCase;
  final UpdatePost updatePostUseCase;
  final DeletePost deletePostUseCase;

  PostProvider({
    required this.getPostsUseCase,
    required this.getPostByIdUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  List<Post> _posts = [];
  Post? _post;
  bool _isLoading = false;
  bool _hasError = false;

  List<Post> get posts => _posts;
  Post? get post => _post;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await getPostsUseCase();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchPostById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _post = await getPostByIdUseCase(id);
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addPost(Post post) async {
    _isLoading = true;
    notifyListeners();
    try {
      await createPostUseCase(post);
      await fetchPosts();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> modifyPost(Post post) async {
    _isLoading = true;
    notifyListeners();
    try {
      await updatePostUseCase(post);
      await fetchPosts();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> removePost(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await deletePostUseCase(id);
      await fetchPosts();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
    _isLoading = false;
    notifyListeners();
  }
}
