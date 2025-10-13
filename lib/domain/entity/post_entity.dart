import 'package:jay_insta_clone/domain/entity/author_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

class PostEntity {
  final int id;
  final String title;
  final String content;
  final String postStatus;
  final String? createdAt;
  final List<CommentEntity>? comments;
  final AuthorEntity author;

  PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.postStatus,
    this.createdAt,
    required this.comments,
    required this.author,
  });

  PostEntity copyWith({
    int? id,
    String? title,
    String? content,
    String? postStatus,
    String? createdAt,
    List<CommentEntity>? comments,
    AuthorEntity? author,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      postStatus: postStatus ?? this.postStatus,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
      author: author ?? this.author,
    );
  }
}
