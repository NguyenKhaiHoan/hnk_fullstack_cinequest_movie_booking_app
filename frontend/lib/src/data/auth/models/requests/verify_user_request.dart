import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_user_request.freezed.dart';
part 'verify_user_request.g.dart';

@freezed
abstract class VerifyUserRequest with _$VerifyUserRequest {
  factory VerifyUserRequest({
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'verification_code') required String verificationCode,
  }) = _VerifyUserRequest;

  factory VerifyUserRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyUserRequestFromJson(json);
}
