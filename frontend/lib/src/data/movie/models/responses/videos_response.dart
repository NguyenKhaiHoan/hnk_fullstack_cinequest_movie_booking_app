import 'package:cinequest/src/data/movie/models/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'videos_response.freezed.dart';
part 'videos_response.g.dart';

@freezed
class VideosResponse with _$VideosResponse {
  factory VideosResponse({
    required int id,
    required List<VideoModel> results,
  }) = _VideosResponse;

  factory VideosResponse.fromJson(Map<String, dynamic> json) =>
      _$VideosResponseFromJson(json);
}
