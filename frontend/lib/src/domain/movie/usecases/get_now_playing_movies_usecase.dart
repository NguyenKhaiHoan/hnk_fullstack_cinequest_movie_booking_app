import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';

class GetNowPlayingMoviesUseCase extends UseCase<List<Movie>, MovieListParams> {
  GetNowPlayingMoviesUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Movie>> call({MovieListParams? params}) {
    return _movieRepository.getNowPlayingMovies(params!);
  }
}
