import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_request.freezed.dart';
part 'token_request.g.dart';

@freezed
abstract class TokenRequest with _$TokenRequest {
  factory TokenRequest() = _TokenRequest;
  factory TokenRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestFromJson(json);
}
