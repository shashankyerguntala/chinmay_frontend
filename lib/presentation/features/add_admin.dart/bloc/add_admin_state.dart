import 'package:equatable/equatable.dart';

abstract class AddAdminState extends Equatable {
  const AddAdminState();

  @override
  List<Object?> get props => [];
}

class AddAdminInitial extends AddAdminState {}

class AddAdminLoading extends AddAdminState {}

class AddAdminSuccess extends AddAdminState {
  final String message;

  const AddAdminSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AddAdminFailure extends AddAdminState {
  final String error;

  const AddAdminFailure(this.error);

  @override
  List<Object?> get props => [error];
}
