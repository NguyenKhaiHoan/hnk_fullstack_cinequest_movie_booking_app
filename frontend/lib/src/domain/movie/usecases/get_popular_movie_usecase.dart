import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/movie.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/_mappers/movie_list_mapper.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';

class GetPopularMoviesUseCase extends UseCase<List<Movie>, MovieListParams> {
  GetPopularMoviesUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  final MovieListMapper _movieListMapper = MovieListMapper();

  @override
  FutureEither<List<Movie>> call({MovieListParams? params}) {
    final request = _movieListMapper.paramsToRequest(params!);
    return _movieRepository.getPopularMovies(request);
  }
}
