import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/location/models/city_model.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';

class CityMapper implements DataMapper<CityModel, City> {
  factory CityMapper() => _instance;
  CityMapper._();
  static final CityMapper _instance = CityMapper._();

  @override
  City toEntity(CityModel model) {
    return City(
      name: model.name,
      slug: model.slug,
      type: model.type,
      nameWithType: model.nameWithType,
      code: model.code,
    );
  }

  @override
  CityModel toModel(City entity) {
    return CityModel(
      name: entity.name,
      slug: entity.slug,
      type: entity.type,
      nameWithType: entity.nameWithType,
      code: entity.code,
    );
  }
}
