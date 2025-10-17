import 'package:jay_insta_clone/domain/entity/moderator_request_entity.dart';
import 'author_model.dart';

class ModeratorRequestModel extends ModeratorRequestEntity {
  ModeratorRequestModel({
    required super.id,
    required super.status,
    required super.username,
    required super.requestedAt,
    required super.author,
  });

  factory ModeratorRequestModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    if (userJson == null) {
      throw Exception('User field is null in moderator request');
    }

    final user = userJson as Map<String, dynamic>;

    return ModeratorRequestModel(
      id: json['id'],
      status: json['requestStatus'],
      username: user['username'],
      requestedAt: DateTime.parse(json['createdAt']),
      author: AuthorModel.fromJson(user),
    );
  }
}
