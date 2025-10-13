import 'package:jay_insta_clone/data%20/models/author_model.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.content,
    required super.commentStatus,
    required super.createdAt,
    required super.postId,
    required super.author,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'] ?? '',
      commentStatus: json['commentStatus'] ?? '',
      createdAt: json['createdAt'],
      postId: json['postId'],
      author: AuthorModel.fromJson(json['author']),
    );
  }
}
