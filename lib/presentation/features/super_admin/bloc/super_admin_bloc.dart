import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';

import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';

import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';

class SuperAdminBloc extends Bloc<SuperAdminEvent, SuperAdminState> {
  final AdminUseCase adminUseCase;
  final ModeratorUseCase moderatorUseCase;

  SuperAdminBloc({required this.adminUseCase, required this.moderatorUseCase})
    : super(SuperAdminInitial()) {
    on<FetchAllSuperAdmin>(_fetchAll);
    on<ApprovePostSuperAdmin>(_approvePost);
    on<RejectPostSuperAdmin>(_rejectPost);
    on<ApproveCommentSuperAdmin>(_approveComment);
    on<RejectCommentSuperAdmin>(_rejectComment);
    on<ApproveModeratorSuperAdmin>(_approveModerator);
    on<RejectModeratorSuperAdmin>(_rejectModerator);
  }

  Future<void> _fetchAll(
    FetchAllSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    emit(SuperAdminLoading());

    try {
      final postsResult = await moderatorUseCase.getPendingPosts();
      final commentsResult = await moderatorUseCase.getPendingComments();
      final modRequestsResult = await adminUseCase.getModeratorRequests();

      postsResult.fold((failure) => emit(SuperAdminError(failure.message)), (
        posts,
      ) {
        commentsResult.fold(
          (failure) => emit(SuperAdminError(failure.message)),
          (comments) {
            modRequestsResult.fold(
              (failure) => emit(SuperAdminError(failure.message)),
              (modRequests) {
                emit(
                  SuperAdminLoaded(
                    posts: posts,
                    comments: comments,
                    moderatorRequests: modRequests,
                  ),
                );
              },
            );
          },
        );
      });
    } catch (e) {
      emit(SuperAdminError(e.toString()));
    }
  }

  Future<void> _approvePost(
    ApprovePostSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final result = await moderatorUseCase.approvePost(event.postId);

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }

  Future<void> _rejectPost(
    RejectPostSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final result = await moderatorUseCase.rejectPost(event.postId);

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }

  Future<void> _approveComment(
    ApproveCommentSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final result = await moderatorUseCase.approveComment(event.commentId);

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }

  Future<void> _rejectComment(
    RejectCommentSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.rejectComment(event.commentId, uid!);

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }

  Future<void> _approveModerator(
    ApproveModeratorSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.approveModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }

  Future<void> _rejectModerator(
    RejectModeratorSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.rejectModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold(
      (failure) => emit(SuperAdminError(failure.message)),
      (_) => add(FetchAllSuperAdmin()),
    );
  }
}
