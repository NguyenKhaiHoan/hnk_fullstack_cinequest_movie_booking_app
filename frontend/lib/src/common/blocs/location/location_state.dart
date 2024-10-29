part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _LocationInitialState;
  const factory LocationState.loading() = _LocationLoadingState;
  const factory LocationState.failed({Failure? failure}) = _LocationFailedState;
  const factory LocationState.success({String? location}) =
      _LocationSuccessState;
}
