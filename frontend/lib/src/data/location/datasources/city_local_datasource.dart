import 'dart:convert';

import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/data/location/models/city_model.dart';
import 'package:flutter/services.dart';

abstract class CityLocalDataSource {
  Future<List<CityModel>> getCities();
  Future<List<CityModel>> searchCity({required String request});
}

class CityLocalDataSourceImpl implements CityLocalDataSource {
  List<CityModel> cities = [];

  Future<void> initializeCityData() async {
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
  }

  @override
  Future<List<CityModel>> getCities() async {
    await initializeCityData();
    return cities;
  }

  @override
  Future<List<CityModel>> searchCity({required String request}) async {
    await initializeCityData();

    final filteredCities = cities.where((city) {
      return city.name.toLowerCase().contains(request.toLowerCase());
    }).toList();

    return filteredCities;
  }
}
