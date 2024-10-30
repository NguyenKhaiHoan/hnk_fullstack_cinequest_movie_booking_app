import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListParams params);
  FutureEither<List<Movie>> getPopularMovies(MovieListParams params);
}
