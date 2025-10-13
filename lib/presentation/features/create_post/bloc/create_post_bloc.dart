import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';

import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';

import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostUseCase postUseCase;

  CreatePostBloc({required this.postUseCase}) : super(CreatePostInitial()) {
    on<SubmitPostEvent>(onSubmitPost);
    on<EditPostEvent>(editPostEvent);
  }

  Future<void> onSubmitPost(
    SubmitPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());

    final result = await postUseCase.createPost(event.title, event.content);

    result.fold(
      (failure) => emit(CreatePostError(error: failure.message)),
      (success) =>
          emit(CreatePostSuccess(message: "Post created successfully!")),
    );
  }

  Future<void> editPostEvent(
    EditPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(CreatePostLoading());

    final uid = await AuthLocalStorage.getUid();
    final result = await postUseCase.editPost(
      event.postId,
      uid!,
      event.title,
      event.content,
    );

    result.fold(
      (failure) => emit(CreatePostError(error: failure.message)),
      (success) =>
          emit(CreatePostSuccess(message: "Post Edited successfully!")),
    );
  }
}
