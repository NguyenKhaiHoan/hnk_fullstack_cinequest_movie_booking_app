part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _AppInitialState;
  const factory AppState.authenticated() = _AppAuthenticatedState;
  const factory AppState.accountNotSetup() = _AppAccountNotSetupState;
  const factory AppState.unauthenticated({Failure? failure}) =
      _AppUnauthenticatedState;
  const factory AppState.findingLocation() = _AppFindingLocationState;
  const factory AppState.invalidLocation() = _AppInvalidLocationState;
}
