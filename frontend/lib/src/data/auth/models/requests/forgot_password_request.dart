import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_request.freezed.dart';
part 'forgot_password_request.g.dart';

@freezed
abstract class ForgotPasswordRequest with _$ForgotPasswordRequest {
  factory ForgotPasswordRequest() = _ForgotPasswordRequest;
  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}
