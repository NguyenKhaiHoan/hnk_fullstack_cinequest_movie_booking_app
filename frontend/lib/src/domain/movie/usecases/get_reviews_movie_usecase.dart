import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/review.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';

class GetReviewsMovieUseCase extends UseCase<List<Review>, MovieDetailsParams> {
  GetReviewsMovieUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Review>> call({MovieDetailsParams? params}) {
    return _movieRepository.getReviewsMovie(params!);
  }
}
