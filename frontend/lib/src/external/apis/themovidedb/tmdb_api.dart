import 'package:cinequest/src/data/movie/models/movie_details_model.dart';
import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:cinequest/src/data/movie/models/responses/credits_response.dart';
import 'package:cinequest/src/data/movie/models/responses/list_response.dart';
import 'package:cinequest/src/data/movie/models/responses/search_movie_response.dart';
import 'package:cinequest/src/data/movie/models/responses/videos_response.dart';
import 'package:cinequest/src/data/movie/models/review_model.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'tmdb_api.g.dart';

@RestApi(baseUrl: TMDBUrl.baseUrl)
abstract class TMDBApi {
  factory TMDBApi(Dio dio) = _TMDBApi;

  @GET(TMDBUrl.getNowPlayingMoviesUrl)
  Future<ListResponse<MovieModel>> getNowPlayingMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getPopularMoviesUrl)
  Future<ListResponse<MovieModel>> getPopularMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getDetailsMovieUrl)
  Future<MovieDetailsModel> getDetailsMovie({
    @Path('movie_id') required int movieId,
    @Query('language') required String language,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getCreditsMovieUrl)
  Future<CreditsResponse> getCreditsMovie({
    @Path('movie_id') required int movieId,
    @Query('language') required String language,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getVideosMovieUrl)
  Future<VideosResponse> getVideosMovie({
    @Path('movie_id') required int movieId,
    @Query('language') required String language,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getReviewsMovieUrl)
  Future<ListResponse<ReviewModel>> getReviewsMovie({
    @Path('movie_id') required int movieId,
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.searchMovieUrlUrl)
  Future<SearchMovieResponse> searchMovie({
    @Query('api_key') required String apiKey,
    @Query('query') required String query,
    @Query('include_adult') required bool includeAdult,
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('primary_release_year') String? primaryReleaseYear,
    @Query('region') String? region,
    @Query('year') String? year,
  });
}
