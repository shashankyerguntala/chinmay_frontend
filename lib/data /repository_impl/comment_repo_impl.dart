import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/comment_data_source.dart';
import 'package:jay_insta_clone/domain/repository/comment_repository.dart';

class CommentRepoImpl implements CommentRepository {
  final CommentDataSource dataSource;

  CommentRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> sendComment(int postId, String content) {
    return dataSource.sendComment(postId, content);
  }
}
