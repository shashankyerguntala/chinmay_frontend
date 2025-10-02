part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  final bool isPasswordObscured;

  const SignUpInitial({this.isPasswordObscured = true});

  @override
  List<Object?> get props => [isPasswordObscured];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User user;

  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isPasswordObscured;

  const SignUpPasswordVisibilityChanged(this.isPasswordObscured);

  @override
  List<Object?> get props => [isPasswordObscured];
}
