part of 'timer_bloc.dart';

@freezed
class TimerEvent with _$TimerEvent {
  const factory TimerEvent.started({required int duration}) =
      _TimerStartedEvent;
  const factory TimerEvent.reset() = _TimerResetEvent;
  const factory TimerEvent.ticked({required int duration}) = _TimerTickedEvent;
}
