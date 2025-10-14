import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';

class PostUseCase {
  final PostRepository repository;

  PostUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    return await repository.getAllPosts();
  }

  Future<Either<Failure, String>> createPost(
    String title,
    String content,
  ) async {
    return await repository.createPost(title, content);
  }

  Future<Either<Failure, List<PostEntity>>> getUserPosts(String userId) async {
    return await repository.getUserPosts(userId);
  }

  Future<Either<Failure, bool>> flagPost(int postId, int userId) async {
    return repository.flagPost(postId, userId);
  }

  Future<Either<Failure, String>> editPost(
    int postId,
    int uid,
    String title,
    String content,
  ) async {
    return await repository.editPost(postId, uid, title, content);
  }

  Future<Either<Failure, bool>> deletePost(int postId) async {
    return await repository.deletePost(postId);
  }
}
