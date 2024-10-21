import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/requests/movie_request.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_params.dart';

class MovieMapper implements DomainMapper<MovieRequest, MovieParams> {
  @override
  MovieRequest paramsToRequest(MovieParams params) {
    return MovieRequest(
      adult: params.adult,
      backdropPath: params.backdropPath,
      genreIds: params.genreIds,
      id: params.id,
      originalLanguage: params.originalLanguage,
      originalTitle: params.originalTitle,
      overview: params.overview,
      popularity: params.popularity,
      posterPath: params.posterPath,
      releaseDate: params.releaseDate,
      title: params.title,
      video: params.video,
      voteAverage: params.voteAverage,
      voteCount: params.voteCount,
    );
  }
}
