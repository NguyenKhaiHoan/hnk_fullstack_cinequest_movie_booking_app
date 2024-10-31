import 'package:cinequest/src/data/movie/models/cast_model.dart';
import 'package:cinequest/src/data/movie/models/crew_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_response.freezed.dart';
part 'credits_response.g.dart';

@freezed
class CreditsResponse with _$CreditsResponse {
  factory CreditsResponse({
    required int id,
    required List<CastModel> cast,
    required List<CrewModel> crew,
  }) = _CreditsResponse;

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditsResponseFromJson(json);
}
