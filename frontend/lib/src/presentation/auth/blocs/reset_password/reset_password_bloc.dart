import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState.initial()) {
    on<ResetPasswordEvent>((event, emit) async {
      event.map(
        emailChanged: (e) => _onEmailChanged(e, emit),
      );
    });
  }

  void _onEmailChanged(
    _ResetPasswordEmailChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        isFormValided: _isFormValided(event.email),
      ),
    );
  }

  bool _isFormValided(String email) {
    return email.isNotEmpty;
  }
}
