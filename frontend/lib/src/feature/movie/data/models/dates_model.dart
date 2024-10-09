// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dates_model.freezed.dart';
part 'dates_model.g.dart';

/// Model
@freezed
abstract class DatesModel with _$DatesModel {
  /// Model
  factory DatesModel({
    @JsonKey(name: 'maximum') DateTime? maximum,
    @JsonKey(name: 'minimum') DateTime? minimum,
  }) = _DatesModel;

  /// fromJson
  factory DatesModel.fromJson(Map<String, dynamic> json) =>
      _$DatesModelFromJson(json);
}
