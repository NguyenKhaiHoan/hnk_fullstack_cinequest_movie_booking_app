import 'dart:convert';

import 'package:cinequest/src/core/env/env.dart';
import 'package:cinequest/src/core/errors/exception/network_exception.dart';
import 'package:cinequest/src/core/errors/exception/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/data/movie/models/cast_model.dart';
import 'package:cinequest/src/data/movie/models/crew_model.dart';
import 'package:cinequest/src/data/movie/models/movie_details_model.dart';
import 'package:cinequest/src/data/movie/models/movie_model.dart';
import 'package:cinequest/src/data/movie/models/responses/credits_response.dart';
import 'package:cinequest/src/data/movie/models/review_model.dart';
import 'package:cinequest/src/data/movie/models/video_model.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies(MovieListParams params);
  Future<List<MovieModel>> getPopularMovies(MovieListParams params);
  Future<MovieDetailsModel> getDetailsMovie(MovieDetailsParams params);
  Future<CreditsResponse> getCreditsMovie(MovieDetailsParams params);
  Future<List<VideoModel>> getVideosMovie(MovieDetailsParams params);
  Future<List<ReviewModel>> getReviewsMovie(MovieDetailsParams params);
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

  List<CastModel> casts = [];
  List<CrewModel> crews = [];
  List<ReviewModel> reviews = [];
  List<VideoModel> videos = [];

  Future<void> initializeCreditsData() async {
    try {
      if (casts.isEmpty && crews.isEmpty) {
        final jsonString =
            await rootBundle.loadString('assets/dumb_data/credits.json');
        final jsonList = json.decode(jsonString) as Map<String, dynamic>;

        casts.addAll(
          (jsonList['cast'] as List<dynamic>)
              .map((json) => CastModel.fromJson(json as Map<String, dynamic>))
              .toList(),
        );

        crews.addAll(
          (jsonList['crew'] as List<dynamic>)
              .map((json) => CrewModel.fromJson(json as Map<String, dynamic>))
              .toList(),
        );
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<void> initializeVideosData() async {
    try {
      if (videos.isEmpty) {
        final jsonString =
            await rootBundle.loadString('assets/dumb_data/videos.json');
        final jsonList = json.decode(jsonString) as Map<String, dynamic>;

        videos.addAll(
          (jsonList['results'] as List<dynamic>)
              .map((json) => VideoModel.fromJson(json as Map<String, dynamic>))
              .toList(),
        );
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<void> initializeReviewsData() async {
    try {
      if (reviews.isEmpty) {
        final jsonString =
            await rootBundle.loadString('assets/dumb_data/reviews.json');
        final jsonList = json.decode(jsonString) as Map<String, dynamic>;

        reviews.addAll(
          (jsonList['results'] as List<dynamic>)
              .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
              .toList(),
        );
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
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

  @override
  Future<MovieDetailsModel> getDetailsMovie(MovieDetailsParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final response = await _tmdbApi.getDetailsMovie(
          movieId: params.movieId,
          language: params.language,
          apiKey: Env.theMovieDbApiKey,
        );
        return response;
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
  Future<CreditsResponse> getCreditsMovie(
    MovieDetailsParams params,
  ) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        // final response = await _tmdbApi.getCreditsMovie(
        //   movieId: params.movieId,
        //   language: params.language,
        //   apiKey: Env.theMovieDbApiKey,
        // );
        // return response;
        await initializeCreditsData();
        return CreditsResponse(id: 1, cast: casts, crew: crews);
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
  Future<List<VideoModel>> getVideosMovie(
    MovieDetailsParams params,
  ) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        // final response = await _tmdbApi.getVideosMovie(
        //   movieId: params.movieId,
        //   language: params.language,
        //   apiKey: Env.theMovieDbApiKey,
        // );
        // return response.results;
        await initializeVideosData();
        return videos;
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
  Future<List<ReviewModel>> getReviewsMovie(
    MovieDetailsParams params,
  ) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        // final response = await _tmdbApi.getReviewsMovie(
        //   movieId: params.movieId,
        //   language: params.language,
        //   page: params.page,
        //   apiKey: Env.theMovieDbApiKey,
        // );
        // return response.results;
        await initializeReviewsData();
        return reviews;
      } on DioException catch (e) {
        throw Failure(
          message: NetworkException.fromDioException(e).message,
        );
      } on Failure {
        rethrow;
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}
