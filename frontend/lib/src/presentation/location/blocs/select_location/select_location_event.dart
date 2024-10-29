part of 'select_location_bloc.dart';

@freezed
class SearchLocationEvent with _$SearchLocationEvent {
  const factory SearchLocationEvent.searched({required String cityName}) =
      _SearchLocationSearchedEvent;
  const factory SearchLocationEvent.loaded() = _SearchLocationLoadedEvent;
}
