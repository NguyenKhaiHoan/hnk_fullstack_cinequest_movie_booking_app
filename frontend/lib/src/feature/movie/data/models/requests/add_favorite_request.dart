import 'package:cinequest/src/feature/movie/data/models/movie_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_favorite_request.freezed.dart';
part 'add_favorite_request.g.dart';

/// Request
@freezed
class AddFavoriteRequest with _$AddFavoriteRequest {
  factory AddFavoriteRequest({
    required MovieModel movie,
    required bool favorite,
  }) = _AddFavoriteRequest;

  // fromJson
  factory AddFavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFavoriteRequestFromJson(json);
}
