part of 'sign_up_bloc.dart';

/// Các sự kiện
@freezed
class SignUpEvent with _$SignUpEvent {
  /// Sự kiện thay đổi email
  const factory SignUpEvent.emailChanged({required String email}) =
      _SignUpEmailChangedEvent;

  /// Sự kiện thay đổi password
  const factory SignUpEvent.setPasswordChanged({required String password}) =
      _SignUpSetPasswordChangedEvent;

  /// Sự kiện thay đổi confirm password
  const factory SignUpEvent.confirmPasswordChanged({
    required String confirmPassword,
  }) = _SignUpConfirmPasswordChangedEvent;

  /// Sự kiện thay đổi vefication code
  const factory SignUpEvent.verificationCodeChanged({
    required String verificationCode,
  }) = _SignUpVerificationCodeChangedEvent;
}
