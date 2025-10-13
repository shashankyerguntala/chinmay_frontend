import 'package:jay_insta_clone/data%20/models/comment_model.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/data%20/models/author_model.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.postStatus,
    super.createdAt,
    required super.author,
    required super.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {

    final authorJson = json['author'] as Map<String, dynamic>?;
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      postStatus: json['postStatus']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      author: authorJson != null
          ? AuthorModel.fromJson(authorJson)
          : AuthorModel(id: 0, username: ''),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => CommentModel.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
