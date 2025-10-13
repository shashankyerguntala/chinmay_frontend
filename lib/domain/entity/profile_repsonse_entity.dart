import 'package:jay_insta_clone/data%20/models/post_model.dart';

class ProfileResponseEntity {
  final String username;
  final String email;
  final List<dynamic> roles;
  final Map<String, List<PostModel>> postsByStatus;

  ProfileResponseEntity({
    required this.roles,
    required this.username,
    required this.email,
    required this.postsByStatus,
  });
}
