import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

/// Quản lý trạng thái của SignUpPage
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) async {
      event.map(
        emailChanged: (e) => _onEmailChanged(e, emit),
        setPasswordChanged: (e) => _onSetPasswordChanged(e, emit),
        confirmPasswordChanged: (e) => _onConfirmPasswordChanged(e, emit),
        verificationCodeChanged: (e) => _onVerificationCodeChanged(e, emit),
      );
    });
  }

  void _onEmailChanged(
    _SignUpEmailChangedEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        isSignUpFormValid: _isSignUpFormValid(
          event.email,
          state.password,
          state.confirmPassword,
        ),
      ),
    );
  }

  void _onSetPasswordChanged(
    _SignUpSetPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        isSignUpFormValid: _isSignUpFormValid(
          state.email,
          event.password,
          state.confirmPassword,
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
    _SignUpConfirmPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        isSignUpFormValid: _isSignUpFormValid(
          state.email,
          state.password,
          event.confirmPassword,
        ),
      ),
    );
  }

  void _onVerificationCodeChanged(
    _SignUpVerificationCodeChangedEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        verificationCode: event.verificationCode,
        isVerificationCodeFormValid:
            _isVerificationCodeFormValid(event.verificationCode),
      ),
    );
  }

  bool _isSignUpFormValid(
    String email,
    String password,
    String confirmPassword,
  ) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  bool _isVerificationCodeFormValid(String verificationCode) {
    return verificationCode.isNotEmpty;
  }
}
