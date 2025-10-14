import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/super_admin_repository.dart';

class SuperAdminUsecase {
  final SuperAdminRepository repository;

  SuperAdminUsecase({required this.repository});

  Future<Either<Failure, List<UserEntity>>> getAdminRequests() {
    return repository.getAdminRequests();
  }

  Future<Either<Failure, bool>> approveAdminRequest(
    int requestId,
    int adminId,
  ) {
    return repository.approveAdminRequest(requestId, adminId);
  }

  Future<Either<Failure, bool>> rejectAdminRequest(int requestId, int adminId) {
    return repository.rejectAdminRequest(requestId, adminId);
  }
}
