// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

/// Model
@freezed
class Response with _$Response {
  /// Model
  const factory Response({
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'status_message') String? statusMessage,
  }) = _Response;

  factory Response.fromJson(Map<String, Object?> json) =>
      _$ResponseFromJson(json);
}
