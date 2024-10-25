part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.emailChanged({required String email}) =
      _LoginEmailChangedEvent;
  const factory LoginEvent.setPasswordChanged({required String password}) =
      _LoginSetPasswordChangedEvent;
}
