import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_setup_bloc.freezed.dart';
part 'account_setup_event.dart';
part 'account_setup_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  AccountSetupBloc() : super(AccountSetupState.initial()) {
    on<AccountSetupEvent>((event, emit) async {
      event.map(
        pageChanged: (e) => _onPageChanged(e, emit),
        usernameChanged: (e) => _onUsernameChanged(e, emit),
        nameChanged: (e) => _onNameChanged(e, emit),
        surnameChanged: (e) => _onSurnameChanged(e, emit),
        bioChanged: (e) => _onBioChanged(e, emit),
        profilePhotoChanged: (e) => _onProfilePhotoChanged(e, emit),
      );
    });
  }

  void _onPageChanged(
    _AccountSetupPageChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(state.copyWith(currentPage: event.index));
  }

  void _onUsernameChanged(
    _AccountSetupUsenameChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        username: event.username,
        isFirstFormValid: _isFormValided(event.username, ''),
      ),
    );
  }

  void _onNameChanged(
    _AccountSetupNameChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
        isFirstFormValid: _isFormValided(event.name, state.surname),
      ),
    );
  }

  void _onSurnameChanged(
    _AccountSetupSurnameChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        surname: event.surname,
        isSecondFormValid: _isFormValided(state.name, event.surname),
      ),
    );
  }

  void _onBioChanged(
    _AccountSetupBioChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        bio: event.bio,
        isThirdFormValid: _isFormValided(event.bio, ''),
      ),
    );
  }

  void _onProfilePhotoChanged(
    _AccountSetupProfilePhotoChangedEvent event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        profilePhoto: event.profilePhoto,
        isProfilePhotoValid: _isProfilePhotoValided(event.profilePhoto),
      ),
    );
  }

  bool _isFormValided(String text1, String text2) {
    if (text2.isNotEmpty) {
      return text1.isNotEmpty && text2.isNotEmpty;
    }
    return text1.isNotEmpty;
  }

  bool _isProfilePhotoValided(File? profilePhoto) {
    return profilePhoto != null;
  }
}
