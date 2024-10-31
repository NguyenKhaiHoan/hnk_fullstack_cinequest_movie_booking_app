import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/movie/datasources/movie_remote_datasource.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/cast_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/crew_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/movie_details_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/movie_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/review_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/video_mapper.dart';
import 'package:cinequest/src/domain/movie/entities/credits.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/entities/review.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
  }) : _movieRemoteDataSource = movieRemoteDataSource;

  final MovieRemoteDataSource _movieRemoteDataSource;
  final MovieMapper _movieMapper = MovieMapper();
  final MovieDetailsMapper _movieDetailsMapper = MovieDetailsMapper();
  final CastMapper _castMapper = CastMapper();
  final CrewMapper _crewMapper = CrewMapper();
  final VideoMapper _videoMapper = VideoMapper();
  final ReviewMapper _reviewMapper = ReviewMapper();

  @override
  FutureEither<List<Movie>> getNowPlayingMovies(
    MovieListParams params,
  ) async {
    try {
      final result = await _movieRemoteDataSource.getNowPlayingMovies(params);
      return Right(result.map(_movieMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Movie>> getPopularMovies(MovieListParams params) async {
    try {
      final result = await _movieRemoteDataSource.getPopularMovies(params);
      return Right(result.map(_movieMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<MovieDetails> getDetailsMovie(MovieDetailsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getDetailsMovie(params);
      return Right(_movieDetailsMapper.toEntity(result));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<Credits> getCreditsMovie(MovieDetailsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getCreditsMovie(params);
      final credits = Credits(
        id: result.id,
        cast: result.cast.map(_castMapper.toEntity).toList(),
        crew: result.crew.map(_crewMapper.toEntity).toList(),
      );
      return Right(credits);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Review>> getReviewsMovie(MovieDetailsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getReviewsMovie(params);
      return Right(result.map(_reviewMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Video>> getVideosMovie(MovieDetailsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getVideosMovie(params);
      return Right(result.map(_videoMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
