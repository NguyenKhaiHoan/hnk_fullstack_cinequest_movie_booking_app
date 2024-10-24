part of 'connectivity_bloc.dart';

@freezed
class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial() = _ConnectivityInitialState;
  const factory ConnectivityState.success() = _ConnectivitySuccessState;
  const factory ConnectivityState.failure({required Failure failure}) =
      _ConnectivityFailureState;
}
