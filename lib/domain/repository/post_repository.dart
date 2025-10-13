import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();

  Future<Either<Failure, String>> createPost(String title, String content);
  Future<Either<Failure, List<PostEntity>>> getUserPosts(
    String userId,
  ); //! ithe bgh string / int

  Future<Either<Failure, bool>> flagPost(int postId, int userId);

  Future<Either<Failure, bool>> editPost(
    int postId,
    int uid,
    String title,
    String content,
  );

  Future<Either<Failure, bool>> deletePost(int postId);
}
