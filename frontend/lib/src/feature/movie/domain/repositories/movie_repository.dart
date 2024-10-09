import 'package:cinequest/src/core/generics/type_def.dart';

import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/get_movie_api_params.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/movie_params.dart';

/// Movie repository
abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(GetMoviesApiParams params);
  FutureEither<List<Movie>> getPopularMovies(GetMoviesApiParams params);
  FutureEither<void> saveMovieLocal(MovieParams params);
  FutureEither<List<Movie>> getMoviesLocal();
  FutureEither<void> deleteMovieLocal(MovieParams params);
  Stream<List<Movie>> favoriteMovies();
}
