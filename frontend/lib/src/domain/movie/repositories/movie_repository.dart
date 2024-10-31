import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/domain/movie/entities/credits.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/entities/review.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListParams params);
  FutureEither<List<Movie>> getPopularMovies(MovieListParams params);
  FutureEither<MovieDetails> getDetailsMovie(MovieDetailsParams params);
  FutureEither<Credits> getCreditsMovie(MovieDetailsParams params);
  FutureEither<List<Video>> getVideosMovie(MovieDetailsParams params);
  FutureEither<List<Review>> getReviewsMovie(MovieDetailsParams params);
}
