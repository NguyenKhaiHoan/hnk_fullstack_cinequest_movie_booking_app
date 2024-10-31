import 'dart:convert';

import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/data/location/models/city_model.dart';
import 'package:flutter/services.dart';

abstract class CityLocalDataSource {
  Future<List<CityModel>> getCities();
  Future<List<CityModel>> searchCity({required String cityName});
}

class CityLocalDataSourceImpl implements CityLocalDataSource {
  List<CityModel> cities = [];

  Future<void> initializeCityData() async {
    try {
      if (cities.isEmpty) {
        final jsonString =
            await rootBundle.loadString(AppConstant.citiesJsonPath);
        final jsonList = json.decode(jsonString) as List<dynamic>;

        cities.addAll(
          jsonList
              .map((json) => CityModel.fromJson(json as Map<String, dynamic>))
              .toList(),
        );
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      await initializeCityData();
    } on Failure {
      rethrow;
    }
    return cities;
  }

  @override
  Future<List<CityModel>> searchCity({required String cityName}) async {
    try {
      await initializeCityData();
    } on Failure {
      rethrow;
    }

    final filteredCities = cities.where((city) {
      return city.name.toLowerCase().contains(cityName.toLowerCase());
    }).toList();

    return filteredCities;
  }
}
