part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required String email,
    required String password,
    required String confirmPassword,
    required String verificationCode,
    required bool isSignUpFormValid,
    required bool isVerificationCodeFormValid,
  }) = _SignUpState;

  factory SignUpState.initial() => const SignUpState(
        email: '',
        password: '',
        confirmPassword: '',
        verificationCode: '',
        isSignUpFormValid: false,
        isVerificationCodeFormValid: true,
      );
}
