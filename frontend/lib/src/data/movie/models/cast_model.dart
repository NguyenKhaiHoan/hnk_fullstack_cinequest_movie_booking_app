import 'package:freezed_annotation/freezed_annotation.dart';

part 'cast_model.freezed.dart';
part 'cast_model.g.dart';

@freezed
class CastModel with _$CastModel {
  factory CastModel({
    @JsonKey(name: 'adult') bool? isAdult,
    int? gender,
    int? id,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    double? popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'cast_id') int? castId,
    String? character,
    @JsonKey(name: 'credit_id') String? creditId,
    int? order,
  }) = _CastModel;

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);
}
