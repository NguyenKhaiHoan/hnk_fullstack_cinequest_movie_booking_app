import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/feature/movie/domain/entities/movie.dart';
import 'package:cinequest/src/feature/movie/domain/repositories/movie_repository.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/get_movie_api_params.dart';

/// Use case lấy dữ liệu danh sách movie phổ biến
class GetPopularMoviesUseCase
    extends FutureAsyncUseCase<List<Movie>, GetMoviesApiParams> {
  /// Constructor
  GetPopularMoviesUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Movie>> call({GetMoviesApiParams? params}) {
    return _movieRepository.getPopularMovies(params!);
  }
}
