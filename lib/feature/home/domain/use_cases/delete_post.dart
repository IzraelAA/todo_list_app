import '../repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;

  DeletePost(this.repository);

  Future<void> call(int id) async {
    return await repository.deletePost(id);
  }
}
