import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:jay_insta_clone/core%20/constants/api_constants.dart';
import 'package:jay_insta_clone/core%20/network/dio_client.dart';
import 'package:jay_insta_clone/core%20/network/failure.dart';
import 'package:jay_insta_clone/data%20/models/profile_response_model.dart';

class ProfileDataSource {
  final DioClient dioClient;

  ProfileDataSource({required this.dioClient});

  Future<Either<Failure, String>> sendModeratorRequest() async {
    final response = await dioClient.postRequest(ApiConstants.becomeModerator);

    return response.fold((fail) => Left(Failure('Request already exists!')), (
      data,
    ) {
      final success = data['success'];
      if (success) {
        return Right("Moderator request sent successfully");
      } else {
        final error = data['message'];
        return Left(Failure(error));
      }
    });
  }

  Future<Either<Failure, ProfileResponseModel>> getUserProfile(
    int userId,
  ) async {
    final response = await dioClient.getRequest(ApiConstants.userProfile);

    return response.fold((failure) => Left(failure), (data) {
      try {
        final jsonData = data is String ? jsonDecode(data) : data;

        final ProfileResponseModel profileModel = ProfileResponseModel.fromJson(
          jsonData as Map<String, dynamic>,
        );

        return Right(profileModel);
      } catch (e) {
        return Left(Failure("Failed to parse user profile: $e"));
      }
    });
  }
}
