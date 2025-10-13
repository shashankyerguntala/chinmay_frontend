

import 'package:jay_insta_clone/domain/entity/sign_up_response_entity.dart';

class SignupResponseModel extends SignupResponseEntity {
  SignupResponseModel({super.response, super.error, super.status});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      response: json['response'],
      error: json['error'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'response': response, 'error': error, 'status': status};
  }
}
