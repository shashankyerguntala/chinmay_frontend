import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';

import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/moderator_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/super_admin_usecase.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_event.dart';
import 'package:jay_insta_clone/presentation/features/super_admin/bloc/super_admin_state.dart';

class SuperAdminBloc extends Bloc<SuperAdminEvent, SuperAdminState> {
  final SuperAdminUsecase superAdminUseCase;
  final AdminUseCase adminUseCase;
  final ModeratorUseCase moderatorUseCase;

  SuperAdminBloc({
    required this.superAdminUseCase,
    required this.adminUseCase,
    required this.moderatorUseCase,
  }) : super(SuperAdminInitial()) {
    on<FetchAllSuperAdmin>(_fetchAll);
    on<ApprovePostSuperAdmin>(_approvePost);
    on<RejectPostSuperAdmin>(_rejectPost);
    on<ApproveCommentSuperAdmin>(_approveComment);
    on<RejectCommentSuperAdmin>(_rejectComment);
    on<ApproveModeratorSuperAdmin>(_approveModerator);
    on<RejectModeratorSuperAdmin>(_rejectModerator);
    on<ApproveAdminSuperAdmin>(_approveAdmin);
    on<RejectAdminSuperAdmin>(_rejectAdmin);
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
      final adminRequestsResult = await superAdminUseCase.getAdminRequests();

      postsResult.fold((failure) => emit(SuperAdminError(failure.message)), (
        posts,
      ) {
        commentsResult.fold(
          (failure) => emit(SuperAdminError(failure.message)),
          (comments) {
            modRequestsResult.fold(
              (failure) => emit(SuperAdminError(failure.message)),
              (modRequests) {
                adminRequestsResult.fold(
                  (failure) => emit(SuperAdminError(failure.message)),
                  (adminRequests) {
                    emit(
                      SuperAdminLoaded(
                        posts: posts,
                        comments: comments,
                        moderatorRequests: modRequests,
                        adminRequests: adminRequests,
                      ),
                    );
                  },
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
    final uid = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.approvePost(event.postId, uid!);

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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
    RejectPostSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.rejectPost(event.postId, uid!);

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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
    ApproveCommentSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.approveComment(event.commentId, uid!);

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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
    RejectCommentSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await moderatorUseCase.rejectComment(event.commentId, uid!);

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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
    ApproveModeratorSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.approveModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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
    RejectModeratorSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await adminUseCase.rejectModeratorRequest(
      event.requestId,
      uid!,
    );

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
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

  Future<void> _approveAdmin(
    ApproveAdminSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await superAdminUseCase.approveAdminRequest(
      event.adminId,
      uid!,
    );

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
        final updatedAdmins = currentState.adminRequests
            .map(
              (a) => a.id == event.adminId ? a.copyWith(status: 'APPROVED') : a,
            )
            .toList();
        emit(currentState.copyWith(adminRequests: updatedAdmins));
      }
    });
  }

  Future<void> _rejectAdmin(
    RejectAdminSuperAdmin event,
    Emitter<SuperAdminState> emit,
  ) async {
    final uid = await AuthLocalStorage.getUid();
    final result = await superAdminUseCase.rejectAdminRequest(
      event.adminId,
      uid!,
    );

    result.fold((failure) => emit(SuperAdminError(failure.message)), (_) {
      if (state is SuperAdminLoaded) {
        final currentState = state as SuperAdminLoaded;
        final updatedAdmins = currentState.adminRequests
            .map(
              (a) => a.id == event.adminId ? a.copyWith(status: 'REJECTED') : a,
            )
            .toList();
        emit(currentState.copyWith(adminRequests: updatedAdmins));
      }
    });
  }
}
