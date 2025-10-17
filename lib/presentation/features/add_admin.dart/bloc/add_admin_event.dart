import 'package:equatable/equatable.dart';

abstract class AddAdminEvent extends Equatable {
  const AddAdminEvent();

  @override
  List<Object?> get props => [];
}

class AddAdminSubmitted extends AddAdminEvent {
  final String name;
  final String email;
  final String password;

  const AddAdminSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}
