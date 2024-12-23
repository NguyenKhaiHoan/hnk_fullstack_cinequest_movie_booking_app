import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/movie_detail.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';

class GetDetailsMovieUseCase extends UseCase<MovieDetails, MovieDetailsParams> {
  GetDetailsMovieUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<MovieDetails> call({MovieDetailsParams? params}) {
    return _movieRepository.getDetailsMovie(params!);
  }
}
