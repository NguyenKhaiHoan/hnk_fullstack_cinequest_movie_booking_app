import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'name_with_type') required String nameWithType,
    @JsonKey(name: 'code') required String code,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
}
