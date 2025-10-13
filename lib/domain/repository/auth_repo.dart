import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/sign_up_response_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String name,
    required String password,
  });

  Future<Either<Failure, SignupResponseEntity>> register({
    required String username,
    required String email,
    required String password,
  });
}
