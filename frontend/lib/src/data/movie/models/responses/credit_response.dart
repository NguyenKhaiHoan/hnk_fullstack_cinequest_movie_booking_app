import 'package:cinequest/src/data/movie/models/cast_model.dart';
import 'package:cinequest/src/data/movie/models/crew_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_response.freezed.dart';
part 'credit_response.g.dart';

@freezed
class CreditResponse with _$CreditResponse {
  factory CreditResponse({
    required int id,
    required List<CastModel> cast,
    required List<CrewModel> crew,
  }) = _CreditResponse;

  factory CreditResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditResponseFromJson(json);
}
