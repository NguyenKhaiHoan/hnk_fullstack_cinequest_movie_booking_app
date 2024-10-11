// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

/// Model
@freezed
class ApiResponse with _$ApiResponse {
  /// Model
  const factory ApiResponse({
    @JsonKey(name: 'success') bool? success,
    @JsonKey(name: 'status_code') int? statusCode,
    @JsonKey(name: 'status_message') String? statusMessage,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, Object?> json) =>
      _$ApiResponseFromJson(json);
}
