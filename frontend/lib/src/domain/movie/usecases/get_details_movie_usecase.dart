import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';

class GetDetailsMovieUseCase extends UseCase<MovieDetails, int> {
  GetDetailsMovieUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<MovieDetails> call({int? params}) {
    return _movieRepository.getDetailsMovie(params!);
  }
}
