import 'package:cinequest/src/core/errors/failure.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class LocationUtil {
  LocationUtil._();

  static Future<List<String>> getAddressFromLatLng(LatLng latLng) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final place = placemarks[0];
      return [
        place.street ?? '',
        place.subAdministrativeArea ?? '',
        place.administrativeArea ?? '',
      ];
    } catch (e) {
      throw Failure(message: "Can't get you address from your position");
    }
  }
}
