import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/post_data_source.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final result = await dataSource.getAllPosts();

    return result.fold((failure) => Left(failure), (models) {
      try {
        final entities = models.map((model) => model).toList();
        return Right(entities);
      } catch (e) {
        return Left(Failure("Failed to convert posts to entities: $e"));
      }
    });
  }

  @override
  Future<Either<Failure, String>> createPost(
    String title,
    String content,
  ) async {
    final result = await dataSource.createPost(title, content);
    return result.fold((failure) => Left(failure), (msg) => Right(msg));
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getUserPosts(String userId) async {
    final result = await dataSource.getUserPosts(userId);
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((m) => m).toList()),
    );
  }

  @override
  Future<Either<Failure, bool>> flagPost(int postId, int userId) async {
    final result = await dataSource.flagPost(postId, userId);
    return result.fold(
      (fail) => left(Failure('error while Flagging post !')),
      (data) => right(data),
    );
  }

  @override
  Future<Either<Failure, bool>> editPost(
    int postId,
    int uid,
    String title,
    String content,
  ) async {
    final result = await dataSource.editPost(postId, uid, title, content);
    return result.fold((failure) => Left(failure), (data) => Right(data));
  }

  @override
  Future<Either<Failure, bool>> deletePost(int postId) async {
    final result = await dataSource.deletePost(postId);
    return result.fold((failure) => Left(failure), (data) => Right(true));
  }
}
