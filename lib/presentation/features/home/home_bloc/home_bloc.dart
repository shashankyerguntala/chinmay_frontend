import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/send_comment_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SendCommentUseCase commentUseCase;
  final PostUseCase postUseCase;

  HomeBloc({required this.postUseCase, required this.commentUseCase})
    : super(HomeInitial()) {
    on<FetchPostsEvent>(onFetchPosts);
    on<FlagPostEvent>(flagPostEvent);
  }

  Future<void> onFetchPosts(
    FetchPostsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final result = await postUseCase.getAllPosts();

      result.fold(
        (failure) {
          emit(HomeError(failure.message));
        },
        (posts) {
          emit(HomeLoaded(posts));
        },
      );
    } catch (e) {
      emit(HomeError("Unexpected error occurred: $e"));
    }
  }

  FutureOr<void> flagPostEvent(
    FlagPostEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    final uid = await AuthLocalStorage.getUid();
    final flagPostResult = await postUseCase.flagPost(event.postId, uid!);
    final getAllPostResult = await postUseCase.getAllPosts();

    flagPostResult.fold(
      (failure) => emit(FlagErrorState(msg: failure.message)),
      (data) => emit(FlagSuccessState(msg: "Post Flagged ")),
    );

    getAllPostResult.fold(
      (failure) => emit(HomeError(failure.message)),
      (posts) => emit(HomeLoaded(posts)),
    );
  }
}
