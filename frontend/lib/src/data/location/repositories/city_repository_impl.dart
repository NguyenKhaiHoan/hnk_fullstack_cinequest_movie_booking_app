import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/location/datasources/_mappers/city_mapper.dart';
import 'package:cinequest/src/data/location/datasources/city_local_datasource.dart';
import 'package:cinequest/src/domain/location/entities/city.dart';
import 'package:cinequest/src/domain/location/repositories/city_repository.dart';
import 'package:dartz/dartz.dart';

class CityRepositoryImpl implements CityRepository {
  CityRepositoryImpl({
    required CityLocalDataSource cityLocalDataSource,
  }) : _cityLocalDataSource = cityLocalDataSource;

  final CityLocalDataSource _cityLocalDataSource;
  final CityMapper _cityMapper = CityMapper();

  @override
  FutureEither<List<City>> getCities() async {
    try {
      final result = await _cityLocalDataSource.getCities();
      return Right(result.map(_cityMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<City>> searchCity(String request) async {
    try {
      final result = await _cityLocalDataSource.searchCity(request: request);
      return Right(result.map(_cityMapper.toEntity).toList());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
