import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/movie/entities/video.dart';
import 'package:cinequest/src/domain/movie/repositories/movie_repository.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_details_params.dart';

class GetVideosMovieUseCase extends UseCase<List<Video>, MovieDetailsParams> {
  GetVideosMovieUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Video>> call({MovieDetailsParams? params}) {
    return _movieRepository.getVideosMovie(params!);
  }
}
