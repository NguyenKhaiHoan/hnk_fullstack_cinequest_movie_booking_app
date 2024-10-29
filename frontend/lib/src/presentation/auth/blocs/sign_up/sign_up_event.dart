part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailChanged({required String email}) =
      _SignUpEmailChangedEvent;
  const factory SignUpEvent.setPasswordChanged({required String password}) =
      _SignUpSetPasswordChangedEvent;
  const factory SignUpEvent.confirmPasswordChanged({
    required String confirmPassword,
  }) = _SignUpConfirmPasswordChangedEvent;
  const factory SignUpEvent.verificationCodeChanged({
    required String verificationCode,
  }) = _SignUpVerificationCodeChangedEvent;
}
