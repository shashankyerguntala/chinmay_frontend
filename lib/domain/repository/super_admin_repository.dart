import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';


abstract class SuperAdminRepository {
  Future<Either<Failure, List<ModeratorRequestModel>>> getAdminRequests();
  Future<Either<Failure, bool>> approveAdminRequest(int requestId, int adminId);
  Future<Either<Failure, bool>> rejectAdminRequest(int requestId, int adminId);
}
