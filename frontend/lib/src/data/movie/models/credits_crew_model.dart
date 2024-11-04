import 'package:freezed_annotation/freezed_annotation.dart';

part 'credits_crew_model.freezed.dart';
part 'credits_crew_model.g.dart';

@freezed
class CreditsCrewModel with _$CreditsCrewModel {
  const factory CreditsCrewModel({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genre_ids') required List<int> genreIds,
    int? id,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    String? title,
    bool? video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    String? department,
    String? job,
    @JsonKey(name: 'credit_id') String? creditId,
  }) = _CreditsCrewModel;

  factory CreditsCrewModel.fromJson(Map<String, dynamic> json) =>
      _$CreditsCrewModelFromJson(json);
}