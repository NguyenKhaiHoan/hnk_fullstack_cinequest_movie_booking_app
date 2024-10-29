part of 'bottom_nav_bloc.dart';

@freezed
class BottomNavEvent with _$BottomNavEvent {
  const factory BottomNavEvent.selectedIndex(int index) =
      _BottomNavSelectedIndexEvent;
}
