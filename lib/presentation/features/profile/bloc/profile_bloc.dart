import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jay_insta_clone/data%20/data_sources/local_data_sources/auth_local_storage.dart';
import 'package:jay_insta_clone/domain/usecase/post_usecase.dart';
import 'package:jay_insta_clone/domain/usecase/profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase profileUsecase;
  final PostUseCase postUseCase;

  ProfileBloc(this.postUseCase, {required this.profileUsecase})
    : super(ProfileInitial()) {
    on<FetchUserDetailsEvent>(_onFetchUserDetails);
    on<SignOutEvent>(_onSignOut);
    on<BecomeModeratorEvent>(_onBecomeModerator);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _onFetchUserDetails(
    FetchUserDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await profileUsecase.getUserProfile(event.userId);

    result.fold((failure) => emit(ProfileError(failure.message)), (
      profileResponse,
    ) {
      emit(
        ProfileLoaded(
          approvedPosts: profileResponse.postsByStatus['APPROVED'] ?? [],
          pendingPosts: profileResponse.postsByStatus['PENDING'] ?? [],
          declinedPosts: profileResponse.postsByStatus['DENIED'] ?? [],
          isModeratorRequest: profileResponse.hasRequestedModerator,
          username: profileResponse.username,
          email: profileResponse.email,
          roles: profileResponse.roles.cast<String>(),
        ),
      );
    });
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await AuthLocalStorage.clearToken();
    await Future.delayed(const Duration(seconds: 2));

    emit(ProfileSignedOut());
  }

  Future<void> _onBecomeModerator(
    BecomeModeratorEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final result = await profileUsecase.sendModeratorRequest();

      result.fold((failure) => emit(ProfileError(failure.message)), (_) {
        emit(
          ProfileModeratorSuccess(
            approvedPosts: currentState.approvedPosts,
            pendingPosts: currentState.pendingPosts,
            declinedPosts: currentState.declinedPosts,
            isModeratorRequest: true,
            username: currentState.username,
            email: currentState.email,
            roles: currentState.roles,
          ),
        );
      });
    }
  }

  FutureOr<void> _onDeletePost(
    DeletePostEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final uid = await AuthLocalStorage.getUid();

    final deleteResult = await postUseCase.deletePost(event.postId);

    await deleteResult.fold((failure) async => emit(DeleteErrorState()), (
      _,
    ) async {
      final result = await profileUsecase.getUserProfile(uid!);
      result.fold((failure) => emit(ProfileError(failure.message)), (
        profileResponse,
      ) {
        emit(
          ProfileLoaded(
            msg: "Post deleted successfully",

            approvedPosts: profileResponse.postsByStatus['APPROVED'] ?? [],
            pendingPosts: profileResponse.postsByStatus['PENDING'] ?? [],
            declinedPosts: profileResponse.postsByStatus['DENIED'] ?? [],
            isModeratorRequest: false,
            username: profileResponse.username,
            email: profileResponse.email,
            roles: profileResponse.roles.cast<String>(),
          ),
        );
      });
    });
  }
}
