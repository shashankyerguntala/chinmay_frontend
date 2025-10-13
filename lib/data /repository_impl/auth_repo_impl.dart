import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/data%20/data_sources/remote_data_sources/auth_data_source.dart';
import 'package:jay_insta_clone/domain/entity/sign_up_response_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String name,
    required String password,
  }) async {
    final result = await remoteDataSource.loginUser(
      name: name,
      password: password,
    );

    return result.fold((failure) => Left(failure), (user) => right(user));
  }

  @override
  Future<Either<Failure, SignupResponseEntity>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.registerUser(
      username: username,
      email: email,
      password: password,
    );

    return result.fold((failure) => Left(failure), (data) => Right(data));
  }
}
