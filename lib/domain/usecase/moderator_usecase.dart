import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';

class ModeratorUseCase {
  final ModeratorRepository repository;

  ModeratorUseCase({required this.repository});

  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    return repository.getPendingPosts();
  }

  Future<Either<Failure, String>> approvePost(int postId) async {
    return repository.approvePost(postId);
  }

  Future<Either<Failure, String>> rejectPost(int postId) async {
    return repository.rejectPost(postId);
  }

  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    return repository.getPendingComments();
  }

  Future<Either<Failure, String>> approveComment(
    int commentId,

  ) async {
    return repository.approveComment(commentId);
  }

  Future<Either<Failure, String>> rejectComment(
    int commentId,
    int userId,
  ) async {
    return repository.rejectComment(commentId);
  }
}
