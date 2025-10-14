import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';
import 'package:jay_insta_clone/data%20/models/user_model.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

class SuperAdminDataSource {
  final DioClient dioClient;

  SuperAdminDataSource({required this.dioClient});

  Future<Either<Failure, List<UserEntity>>> getAdminRequests() async {
    final response = await dioClient.getRequest(ApiConstants.getAdminRequests);

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

  Future<Either<Failure, bool>> approveAdminRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.approveAdmin(requestId),
      data: {"superAdminId": adminId, "action": "APPROVED"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectAdminRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.rejectAdmin(requestId),
      data: {"superAdminId": adminId, "action": "REJECTED"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }
}
