import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';
import 'admin_event.dart';
import 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminUseCase adminUseCase;
  final ModeratorUseCase moderatorUseCase;

  AdminBloc({required this.adminUseCase, required this.moderatorUseCase})
    : super(AdminInitial()) {
    on<FetchAllAdmin>(_fetchAll);
    on<ApprovePostAdmin>(_approvePost);
    on<RejectPostAdmin>(_rejectPost);
    on<ApproveCommentAdmin>(_approveComment);
    on<RejectCommentAdmin>(_rejectComment);
    on<ApproveModeratorAdmin>(_approveModerator);
    on<RejectModeratorAdmin>(_rejectModerator);
  }

  Future<void> _fetchAll(FetchAllAdmin event, Emitter<AdminState> emit) async {
    emit(AdminLoading());

    try {
      final postsResult = await moderatorUseCase.getPendingPosts();
      final commentsResult = await moderatorUseCase.getPendingComments();
      final modRequestsResult = await adminUseCase.getModeratorRequests();

      postsResult.fold((failure) => emit(AdminError(failure.message)), (posts) {
        commentsResult.fold((failure) => emit(AdminError(failure.message)), (
          comments,
        ) {
          modRequestsResult.fold(
            (failure) => emit(AdminError(failure.message)),
            (requests) {
              emit(
                AdminLoaded(
                  posts: posts,
                  comments: comments,
                  moderatorRequests: requests,
                ),
              );
            },
          );
        });
      });
    } catch (e) {
      emit(AdminError(e.toString()));
    }
  }

  Future<void> _approvePost(
    ApprovePostAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.approvePost(event.postId, userId!);

    result.fold((failure) => emit(AdminError(failure.message)), (_) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
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
    RejectPostAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.rejectPost(event.postId, userId!);

    result.fold((failure) => emit(AdminError(failure.message)), (_) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
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
    ApproveCommentAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.approveComment(
      event.commentId,
      userId!,
    );

    result.fold((failure) => emit(AdminError(failure.message)), (_) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
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
    RejectCommentAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final userId = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.rejectComment(
      event.commentId,
      userId!,
    );

    result.fold((failure) => emit(AdminError(failure.message)), (_) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
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

  Future<void> _approveModerator(
    ApproveModeratorAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.approveModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold((failure) => emit(AdminError(failure.message)), (_) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
        final updatedRequests = currentState.moderatorRequests
            .map(
              (r) =>
                  r.id == event.requestId ? r.copyWith(status: 'APPROVED') : r,
            )
            .toList();
        emit(currentState.copyWith(moderatorRequests: updatedRequests));
      }
    });
  }

  Future<void> _rejectModerator(
    RejectModeratorAdmin event,
    Emitter<AdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.rejectModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold((failure) => emit(AdminError(failure.message)), (data) {
      if (state is AdminLoaded) {
        final currentState = state as AdminLoaded;
        final updatedRequests = currentState.moderatorRequests
            .map(
              (r) =>
                  r.id == event.requestId ? r.copyWith(status: 'REJECTED') : r,
            )
            .toList();
        emit(currentState.copyWith(moderatorRequests: updatedRequests));
      }
    });
  }
}
