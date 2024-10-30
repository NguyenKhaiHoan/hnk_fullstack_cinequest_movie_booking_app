import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_movie_response.freezed.dart';
part 'search_movie_response.g.dart';

@freezed
class SearchMovieResponse with _$SearchMovieResponse {
  const factory SearchMovieResponse({
    required int page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _SearchMovieResponse;

  factory SearchMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieResponseFromJson(json);
}
