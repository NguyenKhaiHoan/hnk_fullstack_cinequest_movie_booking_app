import 'package:cinequest/src/external/services/storage/in_memory_store.dart';
import 'package:latlong2/latlong.dart';

class LocationStreamService {
  final _locationState = InMemoryStore<LatLng>(const LatLng(999999, 999999));

  Stream<LatLng> locationStateChanges() => _locationState.stream;

  LatLng? get currentLocation => _locationState.value;

  void updateLocation(LatLng newLocation) {
    _locationState.value = newLocation;
  }

  void dispose() {
    _locationState.close();
  }
}
