import 'package:jay_insta_clone/data%20/models/post_model.dart';

class ProfileResponseEntity {
  final String username;
  final String email;
  final String roles;
  final Map<String, List<PostModel>> postsByStatus;
  final bool hasRequestedModerator;

  ProfileResponseEntity({
    required this.hasRequestedModerator,
    required this.roles,
    required this.username,
    required this.email,
    required this.postsByStatus,
  });
}
