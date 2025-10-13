import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

abstract class CommentRepository {
  Future<Either<Failure, String>> sendComment(int postId, String content);
}
