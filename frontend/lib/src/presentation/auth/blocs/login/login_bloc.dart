import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      event.map(
        emailChanged: (e) => _onEmailChanged(e, emit),
        setPasswordChanged: (e) => _onSetPasswordChanged(e, emit),
      );
    });
  }

  void _onEmailChanged(
    _LoginEmailChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        isFormValided: _isFormValided(event.email, state.password),
      ),
    );
  }

  void _onSetPasswordChanged(
    _LoginSetPasswordChangedEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        isFormValided: _isFormValided(state.email, event.password),
      ),
    );
  }

  bool _isFormValided(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }
}
