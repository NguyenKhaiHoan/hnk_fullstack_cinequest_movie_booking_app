import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_list_request.freezed.dart';
part 'movie_list_request.g.dart';

@freezed
abstract class MovieListRequest with _$MovieListRequest {
  factory MovieListRequest({
    @JsonKey(name: 'language') required String language,
    @JsonKey(name: 'page') required int page,
    @JsonKey(name: 'limi') required int limit,
  }) = _MovieListRequest;
  factory MovieListRequest.fromJson(Map<String, dynamic> json) =>
      _$MovieListRequestFromJson(json);
}
