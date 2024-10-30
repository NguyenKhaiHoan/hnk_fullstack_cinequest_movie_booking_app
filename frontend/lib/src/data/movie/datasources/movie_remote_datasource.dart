import 'package:cinequest/src/core/env/env.dart';
import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/exception/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:dio/dio.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies(MovieListParams params);
  Future<List<MovieModel>> getPopularMovies(MovieListParams params);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  MovieRemoteDataSourceImpl({
    required TMDBApi tmdbApi,
  }) : _tmdbApi = tmdbApi;

  final TMDBApi _tmdbApi;

  @override
  Future<List<MovieModel>> getNowPlayingMovies(MovieListParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final response = await _tmdbApi.getNowPlayingMovies(
          language: params.language,
          page: params.page,
          apiKey: Env.theMovieDbApiKey,
        );
        return response.results;
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies(MovieListParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final response = await _tmdbApi.getPopularMovies(
          language: params.language,
          page: params.page,
          apiKey: Env.theMovieDbApiKey,
        );
        return response.results;
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}
