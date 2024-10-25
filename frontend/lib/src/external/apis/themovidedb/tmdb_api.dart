import 'package:cinequest/src/data/movie/models/responses/movie_list_response.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_url.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'tmdb_api.g.dart';

@RestApi(baseUrl: TMDBUrl.baseUrl)
abstract class TMDBApi {
  factory TMDBApi(Dio dio) = _TMDBApi;

  @GET(TMDBUrl.getNowPlayingMoviesUrl)
  Future<MovieListResponse> getNowPlayingMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });

  @GET(TMDBUrl.getPopularMoviesUrl)
  Future<MovieListResponse> getPopularMovies({
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('api_key') required String apiKey,
  });
}
