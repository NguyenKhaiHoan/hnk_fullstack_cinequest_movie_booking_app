import 'package:cinequest/src/core/extensions/date_time_extension.dart';
import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/feature/movie/data/models/movie_model.dart';
import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';

/// Mapper cho movie
class MovieMapper implements Mapper<MovieModel, Movie> {
  ///
  factory MovieMapper() => _instance;

  MovieMapper._();

  static final MovieMapper _instance = MovieMapper._();

  @override
  Movie modelToEntity(MovieModel dto) {
    return Movie(
      adult: dto.adult,
      backdropPath: dto.backdropPath,
      genreIds: dto.genreIds,
      id: dto.id,
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      overview: dto.overview,
      popularity: dto.popularity,
      posterPath: dto.posterPath,
      releaseDate: DateTime.parse(dto.releaseDate ?? ''),
      title: dto.title,
      video: dto.video,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
    );
  }

  @override
  MovieModel entityToModel(Movie entity) {
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
