import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/moderator_data_source.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';

class ModeratorRepositoryImpl implements ModeratorRepository {
  final ModeratorDataSource dataSource;

  ModeratorRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    final result = await dataSource.getPendingPosts();
    return result.fold(
      (failure) => Left(failure),
      (posts) => Right(posts.map<PostEntity>((e) => e).toList()),
    );
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    final result = await dataSource.getPendingComments();
    return result.fold(
      (failure) => Left(failure),
      (comments) => Right(comments.map<CommentEntity>((e) => e).toList()),
    );
  }

  @override
  Future<Either<Failure, bool>> approveComment(
    int commentId,
    int userId,
  ) async {
    final result = await dataSource.approveComment(commentId, userId);
    return result.fold(
      (fail) => left(Failure('error while approving comment !')),
      (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, bool>> approvePost(int postId, int userId) async {
    final result = await dataSource.approvePost(postId, userId);
    return result.fold(
      (fail) => left(Failure('error while approving post !')),
      (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, bool>> rejectComment(int commentId, int userId) async {
    final result = await dataSource.rejectComment(commentId, userId);
    return result.fold(
      (fail) => left(Failure('error while rejecting comment !')),
      (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, bool>> rejectPost(int postId, int userId) async {
    final result = await dataSource.rejectPost(postId, userId);
    return result.fold(
      (fail) => left(Failure('error while rejecting post !')),
      (data) => right(data),
    );
  }
}
