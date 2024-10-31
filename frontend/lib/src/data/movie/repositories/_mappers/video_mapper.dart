import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/video_model.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';

class VideoMapper implements DataMapper<VideoModel, Video> {
  factory VideoMapper() => _instance;
  VideoMapper._();
  static final VideoMapper _instance = VideoMapper._();

  @override
  Video toEntity(VideoModel model) {
    return Video(
      iso6391: model.iso6391,
      iso31661: model.iso31661,
      name: model.name,
      key: model.key,
      site: model.site,
      size: model.size,
      type: model.type,
      official: model.official,
      publishedAt: model.publishedAt,
      id: model.id,
    );
  }

  @override
  VideoModel toModel(Video entity) {
    throw UnimplementedError();
  }
}
