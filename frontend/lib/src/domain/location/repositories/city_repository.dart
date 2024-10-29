import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';

abstract class CityRepository {
  FutureEither<List<City>> getCities();
  FutureEither<List<City>> searchCity(String request);
}
