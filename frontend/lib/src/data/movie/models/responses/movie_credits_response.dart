import 'package:cinequest/src/data/movie/models/credits_cast_model.dart';
import 'package:cinequest/src/data/movie/models/credits_crew_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_credits_response.freezed.dart';
part 'movie_credits_response.g.dart';

@freezed
class MovieCreditsResponse with _$MovieCreditsResponse {
  const factory MovieCreditsResponse({
    required List<CreditsCastModel> cast,
    required List<CreditsCrewModel> crew,
    int? id,
  }) = _MovieCreditsResponse;

  factory MovieCreditsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsResponseFromJson(json);
}
