import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:cinequest/src/feature/movie/data/models/movie_lists_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'tmdb_api.g.dart';

/// Api TheMovieDb
@RestApi(baseUrl: TMDBUrl.movieBaseUrl)
abstract class TMDBApi {
  factory TMDBApi(Dio dio) = _TMDBApi;

  /// Now playing
  @GET('/movie/now_playing')
  Future<MovieListsModel> getNowPlayingMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  /// Popular
  @GET('/movie/popular')
  Future<MovieListsModel> getPopularMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  // @GET('/movie/{movie_id}/similar')
  // Future<> getSimilarMovies(
  //     {@Path('movie_id') required int movieId,
  //     @Query('api_key') required String apiKey,
  //     @Query('language') required String language,
  //     @Query('page') required int page});

  // @GET('/movie/{movie_id}')
  // Future<> getDetailMovie(
  //     {@Path('movie_id') required int movieId,
  //     @Query('api_key') required String apiKey,
  //     @Query('language') required String language});

  // @GET('/movie/{movie_id}/credits')
  // Future<> getCreditsMovie(
  //     {@Path('movie_id') required int movieId,
  //     @Query('api_key') required String apiKey,
  //     @Query('language') required String language});

  // @GET('/movie/{movie_id}/videos')
  // Future<> getVideosMovie(
  //     {@Path('movie_id') required int movieId,
  //     @Query('api_key') required String apiKey,
  //     @Query('language') required String language});

  // @GET('/search/movie')
  // Future<> searchMovie({
  //   @Query('api_key') required String apiKey,
  //   @Query('query') required String query,
  //   @Query('include_adult') required bool includeAdult,
  //   @Query('language') required String language,
  //   @Query('primary_release_year') String? primaryReleaseYear,
  //   @Query('page') required int page,
  //   @Query('region') String? region,
  //   @Query('year') String? year,
  // });
}
