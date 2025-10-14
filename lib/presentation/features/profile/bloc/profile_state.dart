import 'package:equatable/equatable.dart';

import 'package:jay_insta_clone/domain/entity/post_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String? msg;
  final String username;
  final String email;
  final String roles;
  final List<PostEntity> approvedPosts;
  final List<PostEntity> pendingPosts;
  final List<PostEntity> declinedPosts;
  final bool isModeratorRequest;

  const ProfileLoaded({
    this.msg,
    required this.roles,
    required this.username,
    required this.email,
    required this.approvedPosts,
    required this.pendingPosts,
    required this.declinedPosts,
    this.isModeratorRequest = false,
  });
}

extension ProfileLoadedCopy on ProfileLoaded {
  ProfileLoaded copyWith({
    String? msg,
    String? username,
    String? email,
    String? roles,
    List<PostEntity>? approvedPosts,
    List<PostEntity>? pendingPosts,
    List<PostEntity>? declinedPosts,
    bool? isModeratorRequest,
  }) {
    return ProfileLoaded(
      msg: msg,
      username: username!,
      email: email!,
      approvedPosts: approvedPosts ?? this.approvedPosts,
      pendingPosts: pendingPosts ?? this.pendingPosts,
      declinedPosts: declinedPosts ?? this.declinedPosts,
      isModeratorRequest: isModeratorRequest ?? this.isModeratorRequest,
      roles: roles!,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileSignedOut extends ProfileState {}

class ProfileModeratorSuccess extends ProfileLoaded {
  const ProfileModeratorSuccess({
    required super.approvedPosts,
    required super.pendingPosts,
    required super.declinedPosts,
    required super.isModeratorRequest,
    required super.username,
    required super.email,
    required super.roles,
  });
}

class EditSuccessState extends ProfileState {}

class EditErrorState extends ProfileState {}

class DeleteSuccessState extends ProfileState {}

class DeleteErrorState extends ProfileState {}
