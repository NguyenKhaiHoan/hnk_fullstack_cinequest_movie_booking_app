import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_country_model.freezed.dart';
part 'production_country_model.g.dart';

@freezed
class ProductionCountryModel with _$ProductionCountryModel {
  const factory ProductionCountryModel({
    @JsonKey(name: 'iso_3166_1') required String iso31661,
    required String name,
  }) = _ProductionCountryModel;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryModelFromJson(json);
}
