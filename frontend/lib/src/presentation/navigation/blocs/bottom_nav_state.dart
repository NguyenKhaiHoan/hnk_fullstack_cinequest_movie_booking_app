part of 'bottom_nav_bloc.dart';

@freezed
class BottomNavState with _$BottomNavState {
  const factory BottomNavState({
    required int currentIndex,
  }) = _BottomNavState;

  factory BottomNavState.initial() => const BottomNavState(
        currentIndex: 1,
      );
}
