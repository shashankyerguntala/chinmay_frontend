import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/comment_model.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';

class ModeratorDataSource {
  final DioClient dioClient;

  ModeratorDataSource({required this.dioClient});

  Future<Either<Failure, List<PostModel>>> getPendingPosts() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorPendingPosts,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final posts = (data as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        return Right(posts);
      } catch (e) {
        return Left(Failure("Parsing error: $e"));
      }
    });
  }

  Future<Either<Failure, List<CommentModel>>> getPendingComments() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorPendingComments,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final comments = (data as List)
            .map((json) => CommentModel.fromJson(json))
            .toList();
        return Right(comments);
      } catch (e) {
        return Left(Failure("Parsing error: $e"));
      }
    });
  }

  Future<Either<Failure, bool>> approvePost(int postId, int userId) async {
    final response = await dioClient.putRequest(
      ApiConstants.approvePost(postId),
      data: {"reviewerId": userId, "action": "approved"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectPost(int postId, int userId) async {
    final response = await dioClient.putRequest(
      ApiConstants.rejectPost(postId),
      data: {"reviewerId": userId, "action": "rejected"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> approveComment(
    int commentId,
    int userId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.approveComment(commentId),
      data: {"reviewerId": userId, "action": "approved"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectComment(int commentId, int userId) async {
    final response = await dioClient.putRequest(
      ApiConstants.rejectComment(commentId),
      data: {"reviewerId": userId, "action": "rejected"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }
}
