import 'package:jay_insta_clone/domain/entity/author_entity.dart';

class ModeratorRequestEntity {
  final int id;
  final String status;
  final String username;
  final DateTime requestedAt;
  final AuthorEntity author;

  ModeratorRequestEntity({
    required this.author,
    required this.id,
    required this.status,
    required this.username,
    required this.requestedAt,
  });

  ModeratorRequestEntity copyWith({
    int? id,
    AuthorEntity? author,
    String? status,
    String? username,
    DateTime? requestedAt,
    int? reviewedBy,
  }) {
    return ModeratorRequestEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      username: username ?? this.username,
      requestedAt: requestedAt ?? this.requestedAt,
      author: author ?? this.author,
    );
  }
}
