import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';

import 'package:jay_insta_clone/data%20/models/user_model.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

class AdminDataSource {
  final DioClient dioClient;

  AdminDataSource({required this.dioClient});

  //! get moderator requests
  Future<Either<Failure, List<UserEntity>>> getModeratorRequests() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorRequests,
    );
    //Todo here we can get the error ! !
    return response.fold((failure) => Left(failure), (data) {
      try {
        final apiResponse = ApiResponseModel<List<UserModel>>.fromJson(
          data,
          (jsonList) => (jsonList as List<dynamic>)
              .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList()
              .cast<UserModel>(),
        );

        if (apiResponse.success && apiResponse.data != null) {
          final user = apiResponse.data!
              .map((userModel) => userModel as UserEntity)
              .toList();
          return Right(user);
        } else {
          return Left(Failure(apiResponse.message));
        }
      } catch (e) {
        return Left(Failure("Failed to parse posts: $e"));
      }
    });
  }

  //!approve moderator
  Future<Either<Failure, String>> approveModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.approveModerator(requestId),
      data: {"reason": "User meets moderator criteria"},
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

  //! reject moderator
  Future<Either<Failure, String>> rejectModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.rejectModerator(requestId),
      data: {"reason": "User meets moderator criteria"},
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
