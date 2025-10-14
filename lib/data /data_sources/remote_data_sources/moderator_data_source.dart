import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';
import 'package:jay_insta_clone/data%20/models/comment_model.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

class ModeratorDataSource {
  final DioClient dioClient;

  ModeratorDataSource({required this.dioClient});
  //! pending posts
  Future<Either<Failure, List<PostEntity>>> getPendingPosts() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorPendingPosts,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final apiResponse = ApiResponseModel<List<PostModel>>.fromJson(
          data,
          (jsonList) => (jsonList as List<dynamic>)
              .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
              .toList()
              .cast<PostModel>(),
        );

        if (apiResponse.success && apiResponse.data != null) {
          final postEntities = apiResponse.data!
              .map((postModel) => postModel as PostEntity)
              .toList();
          return Right(postEntities);
        } else {
          return Left(Failure(apiResponse.message));
        }
      } catch (e) {
        return Left(Failure("Failed to parse posts: $e"));
      }
    });
  }

  //! pending comments
  Future<Either<Failure, List<CommentEntity>>> getPendingComments() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorPendingComments,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final apiResponse = ApiResponseModel<List<CommentModel>>.fromJson(
          data,
          (jsonList) => (jsonList as List<dynamic>)
              .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList()
              .cast<CommentModel>(),
        );

        if (apiResponse.success && apiResponse.data != null) {
          final comment = apiResponse.data!
              .map((commentModel) => commentModel as CommentEntity)
              .toList();
          return Right(comment);
        } else {
          return Left(Failure(apiResponse.message));
        }
      } catch (e) {
        return Left(Failure("Failed to parse posts: $e"));
      }
    });
  }

  //! approve post
  Future<Either<Failure, String>> approvePost(int postId) async {
    final response = await dioClient.postRequest(
      ApiConstants.approvePost(postId),
    );

    return response.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel<String>.fromJson(
        data,
        (json) => json?.toString() ?? '',
      );

      if (!apiResponse.success) {
        final errorMessage = apiResponse.error ?? apiResponse.message;
        return Left(Failure(errorMessage));
      }

      return Right(apiResponse.message);
    });
  }

  //! reject post
  Future<Either<Failure, String>> rejectPost(int postId) async {
    final response = await dioClient.postRequest(
      ApiConstants.rejectPost(postId),
    );

    return response.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel<String>.fromJson(
        data,
        (json) => json?.toString() ?? '',
      );

      if (!apiResponse.success) {
        final errorMessage = apiResponse.error ?? apiResponse.message;
        return Left(Failure(errorMessage));
      }

      return Right(apiResponse.message);
    });
  }

  //! comment approve
  Future<Either<Failure, String>> approveComment(int commentId) async {
    final response = await dioClient.postRequest(
      ApiConstants.approveComment(commentId),
      data: {"reason": "Comment is appropriate"},
    );

    return response.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel<String>.fromJson(
        data,
        (json) => json?.toString() ?? '',
      );

      if (!apiResponse.success) {
        final errorMessage = apiResponse.error ?? apiResponse.message;
        return Left(Failure(errorMessage));
      }

      return Right(apiResponse.message);
    });
  }

  Future<Either<Failure, String>> rejectComment(int commentId) async {
    final response = await dioClient.postRequest(
      ApiConstants.rejectComment(commentId),
      data: {"reason": "Comment is appropriate"},
    );

    return response.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel<String>.fromJson(
        data,
        (json) => json?.toString() ?? '',
      );

      if (!apiResponse.success) {
        final errorMessage = apiResponse.error ?? apiResponse.message;
        return Left(Failure(errorMessage));
      }

      return Right(apiResponse.message);
    });
  }
}
