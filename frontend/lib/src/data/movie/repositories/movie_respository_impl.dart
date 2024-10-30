import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/movie/datasources/movie_remote_datasource.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/movie_details_mapper.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/movie_mapper.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
  }) : _movieRemoteDataSource = movieRemoteDataSource;

  final MovieRemoteDataSource _movieRemoteDataSource;
  final MovieMapper _movieMapper = MovieMapper();
  final MovieDetailsMapper _movieDetailsMapper = MovieDetailsMapper();

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
  FutureEither<MovieDetails> getDetailsMovie(int params) async {
    try {
      final result = await _movieRemoteDataSource.getDetailsMovie(params);
      return Right(_movieDetailsMapper.toEntity(result));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
