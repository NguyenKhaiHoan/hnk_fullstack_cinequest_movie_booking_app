import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/movie_details_model.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/genre_mapper.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';

class MovieDetailsMapper extends DataMapper<MovieDetailsModel, MovieDetails> {
  factory MovieDetailsMapper() => _instance;
  MovieDetailsMapper._();
  static final MovieDetailsMapper _instance = MovieDetailsMapper._();

  final GenreMapper _genreMapper = GenreMapper();

  @override
  MovieDetails toEntity(MovieDetailsModel model) {
    return MovieDetails(
      adult: model.adult,
      backdropPath: model.backdropPath,
      budget: model.budget,
      genres: model.genres.map(_genreMapper.toEntity).toList(),
      homepage: model.homepage,
      id: model.id,
      imdbId: model.imdbId,
      originCountry: model.originCountry,
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      overview: model.overview,
      popularity: model.popularity,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      revenue: model.revenue,
      runtime: model.runtime,
      status: model.status,
      tagline: model.tagline,
      title: model.title,
      video: model.video,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }

  @override
  MovieDetailsModel toModel(MovieDetails entity) {
    throw UnimplementedError();
  }
}
