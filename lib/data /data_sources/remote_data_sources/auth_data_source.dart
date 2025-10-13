import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';

import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/data%20/models/api_response_model.dart';
import 'package:jay_insta_clone/data%20/models/sign_up_reponse_model.dart';
import 'package:jay_insta_clone/data%20/models/user_model.dart';
import 'package:jay_insta_clone/domain/entity/sign_up_response_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

class AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSource({required this.dioClient});

  Future<Either<Failure, SignupResponseEntity>> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await dioClient.postRequest(
      ApiConstants.register,
      data: {"username": username, "email": email, "password": password},
    );

    return result.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel.fromJson(
        data,
        (json) => SignupResponseModel.fromJson(json),
      );

      if (apiResponse.success && apiResponse.data != null) {
        return Right(apiResponse.data!);
      } else {
        final message = apiResponse.data?.error ?? apiResponse.message;
        return Left(Failure(message));
      }
    });
  }

  Future<Either<Failure, UserEntity>> loginUser({
    required String name,
    required String password,
  }) async {
    final result = await dioClient.postRequest(
      ApiConstants.login,
      data: {"username": name, "password": password},
    );

    return result.fold((failure) => Left(failure), (data) {
      final apiResponse = ApiResponseModel.fromJson(
        data,
        (json) => UserModel.fromJson(json),
      );

      if (apiResponse.success && apiResponse.data != null) {
        final user = apiResponse.data!;

        final token = (data['data'] != null) ? data['data']['token'] : null;
        if (token != null) AuthLocalStorage.saveToken(token);
        AuthLocalStorage.saveUid(user.id);

        return Right(user);
      } else {
        final message = apiResponse.error;
        return Left(Failure(message!));
      }
    });
  }
}
