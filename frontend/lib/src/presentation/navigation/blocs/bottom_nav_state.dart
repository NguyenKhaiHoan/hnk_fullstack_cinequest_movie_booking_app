part of 'bottom_nav_bloc.dart';

/// Trạng thái
@freezed
class BottomNavState with _$BottomNavState {
  /// Trạng thái
  const factory BottomNavState({
    required int currentIndex,
  }) = _BottomNavState;

  /// Trạng thái ban đầu
  factory BottomNavState.initial() => const BottomNavState(
        currentIndex: 1,
      );
}
