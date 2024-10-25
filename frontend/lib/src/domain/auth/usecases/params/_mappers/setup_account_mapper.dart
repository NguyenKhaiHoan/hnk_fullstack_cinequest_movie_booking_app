import 'dart:convert';

import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/setup_account_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/_mappers/user_details_mapper.dart';
import 'package:cinequest/src/domain/auth/usecases/params/setup_account_params.dart';

class SetupAccountMapper
    implements DomainMapper<SetupAccountRequest, SetupAccountParams> {
  factory SetupAccountMapper() => _instance;
  SetupAccountMapper._();
  static final SetupAccountMapper _instance = SetupAccountMapper._();

  final UserDetailsMapper _userDetailsMapper = UserDetailsMapper();

  @override
  SetupAccountRequest paramsToRequest(SetupAccountParams params) {
    return SetupAccountRequest(
      file: params.file,
      userDetails: jsonEncode(
        _userDetailsMapper.paramsToRequest(params.userDetailsParams).toJson(),
      ),
    );
  }
}
