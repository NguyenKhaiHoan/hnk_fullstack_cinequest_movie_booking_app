import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';
import 'package:cinequest/src/domain/location/repositories/city_repository.dart';

class SearchCityUseCase extends UseCase<List<City>, String> {
  SearchCityUseCase(this._cityRepository);
  final CityRepository _cityRepository;

  @override
  FutureEither<List<City>> call({String? params}) {
    final request = params!;
    return _cityRepository.searchCity(request);
  }
}
