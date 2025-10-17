import 'package:bloc/bloc.dart';

import 'package:jay_insta_clone/domain/usecase/admin_usecase.dart';
import 'add_admin_event.dart';
import 'add_admin_state.dart';

class AddAdminBloc extends Bloc<AddAdminEvent, AddAdminState> {
  final AdminUseCase adminUseCase;

  AddAdminBloc({required this.adminUseCase}) : super(AddAdminInitial()) {
    on<AddAdminSubmitted>(_onAddAdminSubmitted);
  }

  Future<void> _onAddAdminSubmitted(
    AddAdminSubmitted event,
    Emitter<AddAdminState> emit,
  ) async {
    emit(AddAdminLoading());

    final result = await adminUseCase.addAdmin(
      name: event.name,
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AddAdminFailure(failure.message)),
      (message) => emit(AddAdminSuccess(message)),
    );
  }
}
