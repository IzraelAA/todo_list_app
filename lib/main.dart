import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/feature/auth/presentation/pages/splash_screen.dart';
import 'package:todo_list_app/feature/home/data/data_sources/api_service.dart';
import 'package:todo_list_app/feature/home/data/repositories/post_repository.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/create_post.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/delete_post.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/get_post_by_id.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/get_posts.dart';
import 'package:todo_list_app/feature/home/domain/use_cases/update_post.dart';
import 'package:todo_list_app/feature/home/presentation/manager/post_provider.dart';

void main() {
  final apiService = ApiService();
  final postRepository = PostRepositoryImpl(apiService);

  final getPosts = GetPosts(postRepository);
  final getPostById = GetPostById(postRepository);
  final createPost = CreatePost(postRepository);
  final updatePost = UpdatePost(postRepository);
  final deletePost = DeletePost(postRepository);

  runApp(MyApp(
    getPosts: getPosts,
    getPostById: getPostById,
    createPost: createPost,
    updatePost: updatePost,
    deletePost: deletePost,
  ));
}

class MyApp extends StatelessWidget {
  final GetPosts getPosts;
  final GetPostById getPostById;
  final CreatePost createPost;
  final UpdatePost updatePost;
  final DeletePost deletePost;

  MyApp({
    required this.getPosts,
    required this.getPostById,
    required this.createPost,
    required this.updatePost,
    required this.deletePost,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostProvider(
            getPostsUseCase: getPosts,
            getPostByIdUseCase: getPostById,
            createPostUseCase: createPost,
            updatePostUseCase: updatePost,
            deletePostUseCase: deletePost,
          )..fetchPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
