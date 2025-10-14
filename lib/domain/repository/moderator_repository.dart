import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

abstract class ModeratorRepository {
  Future<Either<Failure, List<PostEntity>>> getPendingPosts();
  Future<Either<Failure, List<CommentEntity>>> getPendingComments();
  Future<Either<Failure, String>> approvePost(int postId);
  Future<Either<Failure, String>> rejectPost(int postId);
  Future<Either<Failure, String>> approveComment(int commentId);
  Future<Either<Failure, String>> rejectComment(int commentId);
}
