
import 'package:todo_list_app/feature/home/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> getPostById(int id);
  Future<void> createPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(int id);
}
