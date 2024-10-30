import 'package:freezed_annotation/freezed_annotation.dart';

part 'production_company_model.freezed.dart';
part 'production_company_model.g.dart';

@freezed
class ProductionCompanyModel with _$ProductionCompanyModel {
  const factory ProductionCompanyModel({
    required int id,
    @JsonKey(name: 'logo_path') String? logoPath,
    required String name,
    @JsonKey(name: 'origin_country') required String originCountry,
  }) = _ProductionCompanyModel;

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyModelFromJson(json);
}
