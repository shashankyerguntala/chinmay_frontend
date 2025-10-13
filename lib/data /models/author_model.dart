import 'package:jay_insta_clone/domain/entity/author_entity.dart';

class AuthorModel extends AuthorEntity {
  AuthorModel({required super.id, required super.username});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(id: json['id'], username: json['username']);
  }
}
