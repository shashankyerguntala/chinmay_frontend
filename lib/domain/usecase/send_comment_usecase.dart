import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/domain/repository/comment_repository.dart';

class SendCommentUseCase {
  final CommentRepository repository;

  SendCommentUseCase(this.repository);

  Future<Either<Failure, String>> sendComment(
    int postId,
    String content,
  ) async {
    return await repository.sendComment(postId, content);
  }
}
