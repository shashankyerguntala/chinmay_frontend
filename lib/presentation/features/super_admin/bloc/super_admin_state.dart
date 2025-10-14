import 'package:equatable/equatable.dart';
import 'package:jay_insta_clone/domain/entity/post_entity.dart';
import 'package:jay_insta_clone/domain/entity/comment_entity.dart';

import 'package:jay_insta_clone/domain/entity/user_entity.dart';

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
  final List<UserEntity> moderatorRequests;
  final List<UserEntity> adminRequests;

  const SuperAdminLoaded({
    this.posts = const [],
    this.comments = const [],
    this.moderatorRequests = const [],
    this.adminRequests = const [],
  });

  SuperAdminLoaded copyWith({
    List<PostEntity>? posts,
    List<CommentEntity>? comments,
    List<UserEntity>? moderatorRequests,
    List<UserEntity>? adminRequests,
  }) {
    return SuperAdminLoaded(
      posts: posts ?? this.posts,
      comments: comments ?? this.comments,
      moderatorRequests: moderatorRequests ?? this.moderatorRequests,
      adminRequests: adminRequests ?? this.adminRequests,
    );
  }

  @override
  List<Object?> get props => [
    posts,
    comments,
    moderatorRequests,
    adminRequests,
  ];
}
