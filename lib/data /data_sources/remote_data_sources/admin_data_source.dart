import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';

class AdminDataSource {
  final DioClient dioClient;

  AdminDataSource({required this.dioClient});

  Future<Either<Failure, List<ModeratorRequestModel>>>
  getModeratorRequests() async {
    final response = await dioClient.getRequest(
      ApiConstants.getModeratorRequests,
    );

    return response.fold((failure) => Left(failure), (data) {
      try {
        final List<dynamic> jsonList = data;
        final requests = jsonList
            .map((e) => ModeratorRequestModel.fromJson(e))
            .toList();
        return Right(requests);
      } catch (e) {
        return Left(Failure("Error parsing moderator requests: $e"));
      }
    });
  }

  Future<Either<Failure, bool>> approveModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.approveModerator(requestId),
      data: {"adminId": adminId, "action": "APPROVED"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }

  Future<Either<Failure, bool>> rejectModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final response = await dioClient.putRequest(
      ApiConstants.rejectModerator(requestId),
      data: {"adminId": adminId, "action": "REJECTED"},
    );

    return response.fold((failure) => Left(failure), (_) => const Right(true));
  }
}
