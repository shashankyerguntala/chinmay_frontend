import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/domain/entity/profile_repsonse_entity.dart';
import 'package:jay_insta_clone/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository repository;

  ProfileUsecase(this.repository);

  Future<Either<Failure, String>> sendModeratorRequest() {
    return repository.sendModeratorRequest();
  }

  Future<Either<Failure, ProfileResponseEntity>> getUserProfile(int userId) {
    return repository.getUserProfile(userId);
  }
}
