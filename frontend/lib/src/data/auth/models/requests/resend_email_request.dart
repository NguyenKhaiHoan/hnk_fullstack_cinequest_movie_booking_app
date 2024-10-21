import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_email_request.freezed.dart';
part 'resend_email_request.g.dart';

@freezed
abstract class ResendEmailRequest with _$ResendEmailRequest {
  factory ResendEmailRequest() = _ResendEmailRequest;
  factory ResendEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendEmailRequestFromJson(json);
}
