import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';
import 'package:cinequest/src/domain/location/repositories/city_repository.dart';

class GetCitiesUseCase extends UseCase<List<City>, NoParams> {
  GetCitiesUseCase(this._cityRepository);
  final CityRepository _cityRepository;

  @override
  FutureEither<List<City>> call({NoParams? params}) {
    return _cityRepository.getCities();
  }
}
