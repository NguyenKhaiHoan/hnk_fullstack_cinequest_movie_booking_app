// ignore_for_file: invalid_annotation_target

import 'package:cinequest/src/feature/movie/data/models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_lists_model.freezed.dart';
part 'movie_lists_model.g.dart';

/// Model
@freezed
abstract class MovieListsModel with _$MovieListsModel {
  ///Model
  factory MovieListsModel({
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'results') List<MovieModel>? results,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
  }) = _MovieListsModel;

  /// fromJson
  factory MovieListsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieListsModelFromJson(json);
}
