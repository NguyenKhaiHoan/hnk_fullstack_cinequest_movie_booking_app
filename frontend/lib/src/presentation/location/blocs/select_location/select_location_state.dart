part of 'select_location_bloc.dart';

@freezed
class SearchLocationState with _$SearchLocationState {
  const factory SearchLocationState.loading() = _SearchLocationLoadingState;
  const factory SearchLocationState.failure({Failure? failure}) =
      _SearchLocationFailedState;
  const factory SearchLocationState.success({List<City>? data}) =
      _SearchLocationSuccessState;
}
