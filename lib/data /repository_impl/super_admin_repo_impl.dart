import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/super_admin_data_source.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

import 'package:jay_insta_clone/domain/repository/super_admin_repository.dart';

class SuperAdminRepoImpl implements SuperAdminRepository {
  final SuperAdminDataSource dataSource;

  SuperAdminRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserEntity>>>
  getAdminRequests() async {
    final result = await dataSource.getAdminRequests();
    return result.fold(
      (failure) => Left(failure),
      (requests) => Right(requests),
    );
  }

  @override
  Future<Either<Failure, bool>> approveAdminRequest(
    int requestId,
    int adminId,
  ) async {
    final result = await dataSource.approveAdminRequest(requestId, adminId);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, bool>> rejectAdminRequest(
    int requestId,
    int adminId,
  ) async {
    final result = await dataSource.rejectAdminRequest(requestId, adminId);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
