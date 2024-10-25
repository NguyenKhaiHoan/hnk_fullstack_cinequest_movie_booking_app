import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/requests/movie_list_request.dart';
import 'package:cinequest/src/domain/movie/usecases/params/movie_list_params.dart';

class MovieListMapper
    implements DomainMapper<MovieListRequest, MovieListParams> {
  @override
  MovieListRequest paramsToRequest(MovieListParams params) {
    return MovieListRequest(
      language: params.language,
      page: params.page,
      limit: params.limit,
    );
  }
}
