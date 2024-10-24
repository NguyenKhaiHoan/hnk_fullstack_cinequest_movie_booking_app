import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/movie/models/requests/movie_list_request.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListRequest request);
  FutureEither<List<Movie>> getPopularMovies(MovieListRequest request);
}
