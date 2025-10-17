import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';

import 'package:jay_insta_clone/domain/entity/moderator_request_entity.dart';

class AdminDataSource {
  final DioClient dioClient;

  AdminDataSource({required this.dioClient});

  Future<Either<Failure, List<ModeratorRequestEntity>>>
  getModeratorRequests() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorRequests,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final apiResponse =
            ApiResponseModel<List<ModeratorRequestModel>>.fromJson(data, (
              jsonList,
            ) {
              return (jsonList as List<dynamic>).map((e) {
                return ModeratorRequestModel.fromJson(
                  e as Map<String, dynamic>,
                );
              }).toList();
            });

        if (apiResponse.success && apiResponse.data != null) {
          final List<ModeratorRequestEntity> requests = apiResponse.data!
              .map((e) => e as ModeratorRequestEntity)
              .toList();

          return Right(requests);
        } else {
          return Left(Failure(apiResponse.message));
        }
      } catch (e) {
        return Left(Failure("Failed to parse moderator requests: $e"));
      }
    });
  }

  Future<Either<Failure, String>> approveModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.postRequest(
      ApiConstants.approveModerator(requestId),
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

  Future<Either<Failure, String>> rejectModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.postRequest(
      ApiConstants.rejectModerator(requestId),
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

  Future<Either<Failure, String>> addAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.postRequest(
        ApiConstants.addadmin,
        data: {"username": name, "email": email, "password": password},
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
    } catch (e) {
      return Left(Failure("Failed to add admin: $e"));
    }
  }
}
