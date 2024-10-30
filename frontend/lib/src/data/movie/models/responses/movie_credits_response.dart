import 'package:cinequest/src/data/movie/models/credits_cast_model.dart';
import 'package:cinequest/src/data/movie/models/credits_crew_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_credits_response.freezed.dart';
part 'movie_credits_response.g.dart';

@freezed
class MovieCreditsPersonResponse with _$MovieCreditsPersonResponse {
  const factory MovieCreditsPersonResponse({
    required List<CreditsCastModel> cast,
    required List<CreditsCrewModel> crew,
    int? id,
  }) = _MovieCreditsPersonResponse;

  factory MovieCreditsPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieCreditsPersonResponseFromJson(json);
}
