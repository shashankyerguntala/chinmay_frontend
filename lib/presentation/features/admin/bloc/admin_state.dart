import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';
import 'package:jay_insta_clone/domain/entity/user_entity.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object?> get props => [message];
}

class AdminLoaded extends AdminState {
  final List<PostEntity> posts;
  final List<CommentEntity> comments;
  final List<UserEntity> moderatorRequests;

  const AdminLoaded({
    this.posts = const [],
    this.comments = const [],
    this.moderatorRequests = const [],
  });

  AdminLoaded copyWith({
    List<PostEntity>? posts,
    List<CommentEntity>? comments,
    List<UserEntity>? moderatorRequests,
  }) {
    return AdminLoaded(
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      moderatorRequests: moderatorRequests ?? this.moderatorRequests,
    );
  }

  @override
  List<Object?> get props => [posts, comments, moderatorRequests];
}
