import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/core/utils/genre_util.dart';
import 'package:cinequest/src/data/movie/models/cast_model.dart';
import 'package:cinequest/src/domain/movie/entities/cast.dart';

class CastMapper implements DataMapper<CastModel, Cast> {
  factory CastMapper() => _instance;
  CastMapper._();
  static final CastMapper _instance = CastMapper._();

  @override
  Cast toEntity(CastModel model) {
    return Cast(
      isAdult: model.isAdult,
      gender: GenreUtil.mapGender(model.gender),
      id: model.id,
      knownForDepartment: model.knownForDepartment,
      name: model.name,
      originalName: model.originalName,
      popularity: model.popularity,
      profilePath: model.profilePath,
      castId: model.castId,
      character: model.character,
      creditId: model.creditId,
      order: model.order,
    );
  }

  @override
  CastModel toModel(Cast entity) {
    throw UnimplementedError();
  }
}
