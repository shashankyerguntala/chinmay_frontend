import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/moderator_request_model.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/admin_data_source.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

import 'package:jay_insta_clone/domain/repository/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminDataSource dataSource;

  AdminRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getModeratorRequests() async {
    final result = await dataSource.getModeratorRequests();
    return result.fold(
      (failure) => Left(failure),
      (requests) => Right(requests),
    );
  }

  @override
  Future<Either<Failure, String>> approveModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final result = await dataSource.approveModeratorRequest(requestId, adminId);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }

  @override
  Future<Either<Failure, String>> rejectModeratorRequest(
    int requestId,
    int adminId,
  ) async {
    final result = await dataSource.rejectModeratorRequest(requestId, adminId);
    return result.fold((failure) => Left(failure), (success) => Right(success));
  }
}
