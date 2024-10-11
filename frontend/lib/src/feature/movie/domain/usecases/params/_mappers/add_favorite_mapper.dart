import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/feature/movie/data/datasources/_mapper/movie_mapper.dart';
import 'package:cinequest/src/feature/movie/data/models/requests/add_favorite_request.dart';
import 'package:cinequest/src/feature/movie/domain/usecases/params/add_favorite_params.dart';

/// Mapper
class AddFavoriteMapper
    implements DomainMapper<AddFavoriteRequest, AddFavoriteParams> {
  AddFavoriteMapper({
    required MovieMapper movieMapper,
  }) : _movieMapper = movieMapper;

  final MovieMapper _movieMapper;

  @override
  AddFavoriteRequest paramsToRequest(AddFavoriteParams params) {
    return AddFavoriteRequest(
      movie: _movieMapper.entityToModel(params.movie),
      favorite: params.favorite,
    );
  }
}
