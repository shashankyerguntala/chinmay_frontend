import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';

class CommentDataSource {
  final DioClient dio;

  CommentDataSource({required this.dio});

  Future<Either<Failure, String>> sendComment(
    int postId,
    String content,
  ) async {
    final response = await dio.postRequest(
      ApiConstants.sendComment(postId),
      data: {"content": content},
    );

    return response.fold(
      (fail) => Left(Failure('Error while sending the comment')),
      (data) {
        try {
          final apiResponse = ApiResponseModel.fromJson(data, (value) => true);

          if (apiResponse.success) {
            return Right("Comment sent for approval");
          } else {
            return Left(Failure(apiResponse.message));
          }
        } catch (e) {
          return Left(Failure("Failed to send comment: $e"));
        }
      },
    );
  }
}
