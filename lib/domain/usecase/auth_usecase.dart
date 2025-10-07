import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';
import 'package:jay_insta_clone/domain/repository/auth_repo.dart';

class AuthUsecase {
  final AuthRepository repository;

  const AuthUsecase({required this.repository});
  
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) {
    final response = repository.login(email: email, password: password);
    return response;
  }

  Future<Either<Failure, String>> register({
    required String username,
    required String email,
    required String password,
  }) {
    return repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
