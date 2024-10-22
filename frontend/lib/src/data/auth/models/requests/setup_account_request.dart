import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_account_request.freezed.dart';

@freezed
abstract class SetupAccountRequest with _$SetupAccountRequest {
  factory SetupAccountRequest({
    @JsonKey(name: 'profile_photo') required File file,
    @JsonKey(name: 'user_details') required String userDetails,
  }) = _SetupAccountRequest;
}
