import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:cinequest/src/feature/movie/domain/repositories/movie_repository.dart';

/// Use case theo dõi sự thay đổi của movie
class StreamFavoriteMovieUsecase
    extends StreamSyncUseCase<List<Movie>, NoParams> {
  /// Constructor
  StreamFavoriteMovieUsecase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  Stream<List<Movie>> call({NoParams? params}) {
    return _movieRepository.favoriteMovies();
  }
}
