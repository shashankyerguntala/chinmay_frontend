import 'package:jay_insta_clone/domain/entity/author_entity.dart';

class CommentEntity {
  final int id;
  final String content;
  final String commentStatus;
  final String? createdAt;
  final int postId;
  final AuthorEntity author;

  CommentEntity({
    required this.id,
    required this.content,
    required this.commentStatus,
    this.createdAt,
    required this.postId,
    required this.author,
  });

  CommentEntity copyWith({
    int? id,
    String? content,
    String? commentStatus,
    String? createdAt,
    int? postId,
    AuthorEntity? author,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      commentStatus: commentStatus ?? this.commentStatus,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      author: author ?? this.author,
    );
  }
}
