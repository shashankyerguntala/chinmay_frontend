part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends SignInEvent {
  final String name;
  final String password;

  const SignInRequested({required this.name, required this.password});

  @override
  List<Object?> get props => [name, password];
}

class ShowPasswordEvent extends SignInEvent {}//////////////
