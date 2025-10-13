import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/domain/entity/profile_repsonse_entity.dart';

class ProfileResponseModel extends ProfileResponseEntity {
  ProfileResponseModel({
    required super.username,
    required super.email,
    required super.postsByStatus,
    required super.roles,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    if (data == null) {
      return ProfileResponseModel(
        username: '',
        email: '',
        postsByStatus: {
          'APPROVED': [],
          'PENDING': [],
          'DENIED': [],
          'FLAGGED': [],
        },
        roles: [],
      );
    }

    final postsByStatusJson =
        data['postsByStatus'] as Map<String, dynamic>? ?? {};

    Map<String, List<PostModel>> postsByStatus = {
      'APPROVED': [],
      'PENDING': [],
      'DENIED': [],
      'FLAGGED': [],
    };

    for (var status in postsByStatus.keys) {
      final postsList = postsByStatusJson[status] as List<dynamic>? ?? [];
      postsByStatus[status] = postsList
          .map((p) => PostModel.fromJson(p as Map<String, dynamic>))
          .toList();
    }

    return ProfileResponseModel(
      username: data['username']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      postsByStatus: postsByStatus,
      roles: data['roles'],
    );
  }
}
