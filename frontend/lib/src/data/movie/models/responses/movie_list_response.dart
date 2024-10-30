import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_list_response.freezed.dart';
part 'movie_list_response.g.dart';

@freezed
class MovieListResponse with _$MovieListResponse {
  factory MovieListResponse({
    required int page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_results') required int totalResults,
  }) = _MovieListResponse;

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);
}
