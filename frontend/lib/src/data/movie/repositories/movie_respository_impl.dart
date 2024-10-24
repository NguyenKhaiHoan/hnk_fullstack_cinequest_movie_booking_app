import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/movie/datasources/_mapper/movie_mapper.dart';
import 'package:cinequest/src/data/movie/datasources/movie_remote_datasource.dart';
import 'package:cinequest/src/data/movie/models/requests/movie_list_request.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
  }) : _movieRemoteDataSource = movieRemoteDataSource;

  final MovieRemoteDataSource _movieRemoteDataSource;

  final MovieMapper _movieMapper = MovieMapper();

  @override
  FutureEither<List<Movie>> getNowPlayingMovies(
    MovieListRequest request,
  ) async {
    try {
      final result = await _movieRemoteDataSource.getNowPlayingMovies(request);
      return Right(result.map(_movieMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Movie>> getPopularMovies(MovieListRequest request) async {
    try {
      final result = await _movieRemoteDataSource.getPopularMovies(request);
      return Right(result.map(_movieMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
