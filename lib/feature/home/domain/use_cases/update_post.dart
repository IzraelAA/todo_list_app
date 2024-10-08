import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  UpdatePost(this.repository);

  Future<void> call(Post post) async {
    return await repository.updatePost(post);
  }
}
