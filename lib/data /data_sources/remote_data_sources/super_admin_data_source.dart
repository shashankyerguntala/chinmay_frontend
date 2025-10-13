import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';

class SuperAdminDataSource {
  final DioClient dioClient;

  SuperAdminDataSource({required this.dioClient});

  Future<Either<Failure, List<ModeratorRequestModel>>>
  getAdminRequests() async {
    final response = await dioClient.getRequest(ApiConstants.getAdminRequests);

    return response.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonList = data;
        final requests = jsonList
            .map((e) => ModeratorRequestModel.fromJson(e))
            .toList();
        return Right(requests);
      } catch (e) {
        return Left(Failure("Error parsing Admin requests: $e"));
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
