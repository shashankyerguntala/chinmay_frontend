import 'package:equatable/equatable.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  final String message;

  const CreatePostSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreatePostError extends CreatePostState {
  final String error;

  const CreatePostError({required this.error});

  @override
  List<Object?> get props => [error];
}
