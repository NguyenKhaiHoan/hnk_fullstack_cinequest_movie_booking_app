import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:cinequest/src/feature/movie/domain/repositories/movie_repository.dart';

/// Use case lấy movie từ local database
class GetMovieLocalUseCase extends FutureAsyncUseCase<List<Movie>, NoParams> {
  /// Constructor
  GetMovieLocalUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Movie>> call({NoParams? params}) {
    return _movieRepository.getMoviesLocal();
  }
}
