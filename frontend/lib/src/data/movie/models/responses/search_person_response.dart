import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_person_response.freezed.dart';
part 'search_person_response.g.dart';

@freezed
class SearchPersonResponse with _$SearchPersonResponse {
  const factory SearchPersonResponse({
    required List<Person> results,
    int? page,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
  }) = _SearchPersonResponse;

  factory SearchPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchPersonResponseFromJson(json);
}

@freezed
class Person with _$Person {
  const factory Person({
    bool? adult,
    int? gender,
    int? id,
    @JsonKey(name: 'known_for_department') String? knownForDepartment,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    double? popularity,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'known_for') List<KnownFor>? knownFor,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

@freezed
class KnownFor with _$KnownFor {
  const factory KnownFor({
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    int? id,
    String? name,
    @JsonKey(name: 'original_name') String? originalName,
    String? overview,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'media_type') String? mediaType,
    bool? adult,
    @JsonKey(name: 'original_language') String? originalLanguage,
    List<int>? genreIds,
    double? popularity,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'release_date') String? releaseDate,
    bool? video,
  }) = _KnownFor;

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);
}
