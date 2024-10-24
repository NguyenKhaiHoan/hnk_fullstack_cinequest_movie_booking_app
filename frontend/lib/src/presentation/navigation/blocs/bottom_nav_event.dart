part of 'bottom_nav_bloc.dart';

/// Các sự kiện
@freezed
class BottomNavEvent with _$BottomNavEvent {
  /// Sự kiện chọn index ở thanh bottom navigation của HomePage
  const factory BottomNavEvent.selectedIndex(int index) =
      _BottomNavSelectedIndexEvent;
}
