part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  const factory ResetPasswordEvent.emailChanged({required String email}) =
      _ResetPasswordEmailChangedEvent;
}
