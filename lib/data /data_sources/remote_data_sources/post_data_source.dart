import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';
import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';

class PostDataSource {
  final DioClient dioClient;

  PostDataSource(this.dioClient);
//! get all posts 
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    final result = await dioClient.getRequest(ApiConstants.getAllPosts);

    return result.fold((failure) => Left(failure), (data) {
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

  //! create post
  Future<Either<Failure, String>> createPost(
    String title,
    String content,
  ) async {
    final response = await dioClient.postRequest(
      ApiConstants.createPost,
      data: {"title": title, "content": content},
    );
    return response.fold((failure) => Left(failure), (data) {
      try {
        final apiResponse = ApiResponseModel.fromJson(data, (value) => true);

        if (apiResponse.success) {
          return Right("Post sent for approval");
        } else {
          return Left(Failure(apiResponse.message));
        }
      } catch (e) {
        return Left(Failure("Failed to create Post !"));
      }
    });
  }

  //! get user posts
  Future<Either<Failure, List<PostModel>>> getUserPosts(String userId) async {
    final response = await dioClient.getRequest(ApiConstants.userPosts(userId));
    return response.fold((left) => Left(left), (data) {
      final posts = (data as List).map((e) => PostModel.fromJson(e)).toList();
      return Right(posts);
    });
  }
//! flag post
  Future<Either<Failure, bool>> flagPost(int postId, int userId) async {
    final response = await dioClient.putRequest(
      ApiConstants.flagPost(postId),
      data: {"reviewerId": userId, "action": "disapproved"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  //! edit post
  Future<Either<Failure, String>> editPost(
    int postId,

    String title,
    String content,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.updatePost(postId),
      data: {"title": title, "content": content},
    );
    return response.fold(
      (failure) => Left(failure),
      (data) => Right(data['message']),
    );
  }

  //! delete post
  Future<Either<Failure, String>> deletePost(int postId) async {
    final response = await dioClient.deleteRequest(
      ApiConstants.deletePost(postId),
    );
    return response.fold((failure) => Left(failure), (data) {
      final message = data['message'];
      return Right(message);
    });
  }
}
