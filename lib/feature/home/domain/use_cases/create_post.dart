import '../entities/post.dart';
import '../repositories/post_repository.dart';

class CreatePost {
  final PostRepository repository;

  CreatePost(this.repository);

  Future<void> call(Post post) async {
    return await repository.createPost(post);
  }
}
