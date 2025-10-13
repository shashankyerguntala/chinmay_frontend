import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/profile_data_source.dart';

import 'package:jay_insta_clone/domain/entity/profile_repsonse_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> sendModeratorRequest() async {
    final result = await dataSource.sendModeratorRequest();
    return result.fold(
      (failure) => Left(failure),
      (message) => Right(message),
    );
  }

  @override
  Future<Either<Failure, ProfileResponseEntity>> getUserProfile(
    int userId,
  ) async {
    final result = await dataSource.getUserProfile(userId);
    return result.fold(
      (failure) => Left(failure),
      (profileResponseModel) => Right(profileResponseModel),
    );
  }
}
