import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/core/utils/genre_util.dart';
import 'package:cinequest/src/data/movie/models/crew_model.dart';
import 'package:cinequest/src/domain/movie/entities/crew.dart';

class CrewMapper implements DataMapper<CrewModel, Crew> {
  factory CrewMapper() => _instance;
  CrewMapper._();
  static final CrewMapper _instance = CrewMapper._();

  @override
  Crew toEntity(CrewModel model) {
    return Crew(
      isAdult: model.isAdult,
      gender: GenreUtil.mapGender(model.gender),
      id: model.id,
      knownForDepartment: model.knownForDepartment,
      name: model.name,
      originalName: model.originalName,
      popularity: model.popularity,
      profilePath: model.profilePath,
      creditId: model.creditId,
      department: model.department,
      job: model.job,
    );
  }

  @override
  CrewModel toModel(Crew entity) {
    throw UnimplementedError();
  }
}
