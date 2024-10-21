part of 'button_bloc.dart';

@freezed
class ButtonState with _$ButtonState {
  const factory ButtonState.initial() = _ButtonInitialState;
  const factory ButtonState.loading() = _ButtonLoadingState;
  const factory ButtonState.success() = _ButtonSuccessState;
  const factory ButtonState.failure({required Failure failure}) =
      _ButtonFailureState;
}
