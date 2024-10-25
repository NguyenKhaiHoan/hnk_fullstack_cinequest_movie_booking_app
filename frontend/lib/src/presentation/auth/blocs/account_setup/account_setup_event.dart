part of 'account_setup_bloc.dart';

@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  const factory AccountSetupEvent.pageChanged({required int index}) =
      _AccountSetupPageChangedEvent;
  const factory AccountSetupEvent.usernameChanged({required String username}) =
      _AccountSetupUsenameChangedEvent;
  const factory AccountSetupEvent.nameChanged({required String name}) =
      _AccountSetupNameChangedEvent;
  const factory AccountSetupEvent.surnameChanged({required String surname}) =
      _AccountSetupSurnameChangedEvent;
  const factory AccountSetupEvent.bioChanged({required String bio}) =
      _AccountSetupBioChangedEvent;
  const factory AccountSetupEvent.profilePhotoChanged({
    required File? profilePhoto,
  }) = _AccountSetupProfilePhotoChangedEvent;
}
