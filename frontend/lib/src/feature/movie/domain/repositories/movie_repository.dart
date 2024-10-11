import 'package:cinequest/src/core/generics/type_def.dart';

import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/get_movie_api_params.dart';

/// Movie repository
abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListParams params);
  FutureEither<List<Movie>> getPopularMovies(MovieListParams params);
}
