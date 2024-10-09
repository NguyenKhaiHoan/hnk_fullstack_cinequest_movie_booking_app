import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

/// Params của các use case DeleteMovieLocalUseCase, SaveMovieLocalUseCase, ...
class MovieParams extends Equatable {
  /// Constructor
  const MovieParams({
    required this.movie,
    this.movies,
  });

  final Movie movie;

  /// Cho trường hợp lưu movie vào favorite, để truyền vào stream để theo dõi
  /// sự thay đổi
  final List<Movie>? movies;

  @override
  List<Object?> get props => [movie, movies];
}
