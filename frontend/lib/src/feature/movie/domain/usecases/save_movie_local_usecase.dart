import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/feature/movie/domain/repositories/movie_repository.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/movie_params.dart';

/// Use case lưu movie vào local database
class SaveMovieLocalUseCase extends FutureAsyncUseCase<void, MovieParams> {
  /// Constructor
  SaveMovieLocalUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<void> call({MovieParams? params}) {
    return _movieRepository.saveMovieLocal(params!);
  }
}
