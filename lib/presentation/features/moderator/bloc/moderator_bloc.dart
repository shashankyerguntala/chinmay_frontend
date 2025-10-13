import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';
import 'moderator_event.dart';
import 'moderator_state.dart';

class ModeratorBloc extends Bloc<ModeratorEvent, ModeratorState> {
  final ModeratorUseCase useCase;

  ModeratorBloc({required this.useCase}) : super(ModeratorInitial()) {
    on<FetchAll>(_fetchAll);
    on<ApprovePost>(_approvePost);
    on<RejectPost>(_rejectPost);
    on<ApproveComment>(_approveComment);
    on<RejectComment>(_rejectComment);
  }

  Future<void> _fetchAll(FetchAll event, Emitter<ModeratorState> emit) async {
    emit(ModeratorLoading());
    final postsResult = await useCase.getPendingPosts();
    final commentsResult = await useCase.getPendingComments();

    postsResult.fold((failure) => emit(ModeratorError(failure.message)), (
      posts,
    ) {
      commentsResult.fold(
        (failure) => emit(ModeratorError(failure.message)),
        (comments) => emit(ModeratorLoaded(posts: posts, comments: comments)),
      );
    });
  }

  Future<void> _approvePost(
    ApprovePost event,
    Emitter<ModeratorState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await useCase.approvePost(event.postId, userId!);
    result.fold((failure) => emit(ModeratorError(failure.message)), (_) {
      if (state is ModeratorLoaded) {
        final currentState = state as ModeratorLoaded;
        final updatedPosts = currentState.posts
            .map(
              (p) => p.id == event.postId ? p.copyWith(postStatus: 'approved') : p,
            )
            .toList();
        emit(currentState.copyWith(posts: updatedPosts));
      }
    });
  }

  Future<void> _rejectPost(
    RejectPost event,
    Emitter<ModeratorState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await useCase.rejectPost(event.postId, userId!);
    result.fold((failure) => emit(ModeratorError(failure.message)), (_) {
      if (state is ModeratorLoaded) {
        final currentState = state as ModeratorLoaded;
        final updatedPosts = currentState.posts
            .map(
              (p) => p.id == event.postId ? p.copyWith(postStatus: 'rejected') : p,
            )
            .toList();
        emit(currentState.copyWith(posts: updatedPosts));
      }
    });
  }

  Future<void> _approveComment(
    ApproveComment event,
    Emitter<ModeratorState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await useCase.approveComment(event.commentId, userId!);
    result.fold((failure) => emit(ModeratorError(failure.message)), (_) {
      if (state is ModeratorLoaded) {
        final currentState = state as ModeratorLoaded;
        final updatedComments = currentState.comments
            .map(
              (c) =>
                  c.id == event.commentId ? c.copyWith(commentStatus: 'approved') : c,
            )
            .toList();
        emit(currentState.copyWith(comments: updatedComments));
      }
    });
  }

  Future<void> _rejectComment(
    RejectComment event,
    Emitter<ModeratorState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await useCase.rejectComment(event.commentId, userId!);
    result.fold((failure) => emit(ModeratorError(failure.message)), (_) {
      if (state is ModeratorLoaded) {
        final currentState = state as ModeratorLoaded;
        final updatedComments = currentState.comments
            .map(
              (c) =>
                  c.id == event.commentId ? c.copyWith(commentStatus: 'rejected') : c,
            )
            .toList();
        emit(currentState.copyWith(comments: updatedComments));
      }
    });
  }
}
