import 'dart:developer';

import 'package:cinequest/src/common/constants/app_constant.dart';
import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions',
      );
    }

    final currentPosition = await Geolocator.getCurrentPosition();

    await sl<GetStorageService>().saveData(
      AppConstant.latitude,
      currentPosition.latitude,
    );
    await sl<GetStorageService>().saveData(
      AppConstant.longitude,
      currentPosition.longitude,
    );

    log('------------- latitude: ${currentPosition.latitude}');
    log('------------- longitude: ${currentPosition.longitude}');
    return currentPosition;
  }
}
