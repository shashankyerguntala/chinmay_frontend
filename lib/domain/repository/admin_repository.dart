import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class AdminRepository {
  Future<Either<Failure, List<UserEntity>>> getModeratorRequests();
  Future<Either<Failure, String>> approveModeratorRequest(
    int requestId,
    int adminId,
  );
  Future<Either<Failure, String>> rejectModeratorRequest(
    int requestId,
    int adminId,
  );
}
