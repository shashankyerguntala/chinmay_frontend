import 'package:jay_insta_clone/data%20/models/post_model.dart';
import 'package:jay_insta_clone/domain/entity/profile_repsonse_entity.dart';

class ProfileResponseModel extends ProfileResponseEntity {
  ProfileResponseModel({
    required super.username,
    required super.email,
    required super.postsByStatus,
    required super.roles,
    required super.hasRequestedModerator,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    final postsByStatusJson =
        data['postsByStatus'] as Map<String, dynamic>? ?? {};

    final Map<String, List<PostModel>> postsByStatus = {
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

    final role = data['role'];

    return ProfileResponseModel(
      username: data['username']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      postsByStatus: postsByStatus,
      roles: role,
      hasRequestedModerator: data['moderatorRequest'] ?? false,
    );
  }
}
