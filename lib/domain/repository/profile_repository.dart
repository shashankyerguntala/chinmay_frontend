import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';

import 'package:jay_insta_clone/domain/entity/profile_repsonse_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> sendModeratorRequest();

  Future<Either<Failure, ProfileResponseEntity>> getUserProfile(int userId);
}
