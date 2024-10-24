import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';

class MovieMapper implements DataMapper<MovieModel, Movie> {
  factory MovieMapper() => _instance;
  MovieMapper._();
  static final MovieMapper _instance = MovieMapper._();

  @override
  Movie toEntity(MovieModel model) {
    return Movie(
      adult: model.adult,
      backdropPath: model.backdropPath,
      genreIds: model.genreIds,
      id: model.id,
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      overview: model.overview,
      popularity: model.popularity,
      posterPath: model.posterPath,
      releaseDate: DateTime.parse(model.releaseDate ?? ''),
      title: model.title,
      video: model.video,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }

  @override
  MovieModel toModel(Movie entity) {
    return MovieModel(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate!.toFormattedString(),
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}
