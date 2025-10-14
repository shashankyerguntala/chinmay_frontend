import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/moderator_data_source.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/repository/moderator_repository.dart';

class ModeratorRepositoryImpl implements ModeratorRepository {
  final ModeratorDataSource dataSource;

  ModeratorRepositoryImpl({required this.dataSource});
  //! get comments
  @override
  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    final result = await dataSource.getPendingPosts();
    return result.fold((failure) => Left(failure), (posts) => Right(posts));
  }

  //! get posts
  @override
  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    final result = await dataSource.getPendingComments();
    return result.fold(
      (failure) => Left(failure),
      (comments) => Right(comments),
    );
  }
//! approve comment 
  @override
  Future<Either<Failure, String>> approveComment(int commentId) async {
    final result = await dataSource.approveComment(commentId);
    return result.fold(
      (fail) => left(Failure('error while approving comment !')),
      (data) => right(data),
    );
  }

  //!approve post
  @override
  Future<Either<Failure, String>> approvePost(int postId) async {
    final result = await dataSource.approvePost(postId);
    return result.fold(
      (fail) => left(Failure('error while approving post !')),
      (data) => right(data),
    );
  }
//! reject comment
  @override
  Future<Either<Failure, String>> rejectComment(int commentId) async {
    final result = await dataSource.rejectComment(commentId);
    return result.fold(
      (fail) => left(Failure('error while rejecting comment !')),
      (data) => right(data),
    );
  }
//! reject post 
  @override
  Future<Either<Failure, String>> rejectPost(int postId) async {
    final result = await dataSource.rejectPost(postId);
    return result.fold(
      (fail) => left(Failure('error while rejecting post !')),
      (data) => right(data),
    );
  }
}
