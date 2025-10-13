import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:jay_insta_clone/domain/usecase/auth_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUsecase authUsecase;
  bool isPasswordObscured = true;

  SignUpBloc({required this.authUsecase}) : super(const SignUpInitial()) {
    on<ShowPasswordEvent>((event, emit) {
      isPasswordObscured = !isPasswordObscured;
      emit(SignUpPasswordVisibilityChanged(isPasswordObscured));
    });

    on<SignUpRequested>((event, emit) async {
      emit(SignUpLoading());
      final result = await authUsecase.register(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      result.fold((failure) => emit(SignUpFailure(failure.message)), (data) {
        if (data.error != null) {
          emit(SignUpFailure(data.error!));
        } else {
          emit(SignUpSuccess(data.response!));
        }
      });
    });
  }
}
