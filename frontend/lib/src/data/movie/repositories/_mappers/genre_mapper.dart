import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/genre_model.dart';
import 'package:cinequest/src/domain/movie/entities/genre.dart';

class GenreMapper implements DataMapper<GenreModel, Genre> {
  factory GenreMapper() => _instance;
  GenreMapper._();
  static final GenreMapper _instance = GenreMapper._();

  @override
  Genre toEntity(GenreModel model) {
    return Genre(
      id: model.id,
      name: model.name,
    );
  }

  @override
  GenreModel toModel(Genre entity) {
    return GenreModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
