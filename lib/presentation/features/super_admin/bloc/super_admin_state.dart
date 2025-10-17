import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/domain/entity/moderator_request_entity.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

abstract class SuperAdminState extends Equatable {
  const SuperAdminState();
  @override
  List<Object?> get props => [];
}

class SuperAdminInitial extends SuperAdminState {}

class SuperAdminLoading extends SuperAdminState {}

class SuperAdminError extends SuperAdminState {
  final String message;
  const SuperAdminError(this.message);
  @override
  List<Object?> get props => [message];
}

class SuperAdminLoaded extends SuperAdminState {
  final List<PostEntity> posts;
  final List<CommentEntity> comments;
  final List<ModeratorRequestEntity> moderatorRequests;

  const SuperAdminLoaded({
    this.posts = const [],
    this.comments = const [],
    this.moderatorRequests = const [],
  });

  SuperAdminLoaded copyWith({
    List<PostEntity>? posts,
    List<CommentEntity>? comments,
    List<ModeratorRequestEntity>? moderatorRequests,
  }) {
    return SuperAdminLoaded(
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      moderatorRequests: moderatorRequests ?? this.moderatorRequests,
    );
  }

  @override
  List<Object?> get props => [posts, comments, moderatorRequests];
}
