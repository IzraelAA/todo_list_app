
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostById {
  final PostRepository repository;

  GetPostById(this.repository);

  Future<Post> call(int id) async {
    return await repository.getPostById(id);
  }
}
