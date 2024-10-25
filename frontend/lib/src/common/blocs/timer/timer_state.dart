part of 'timer_bloc.dart';

@freezed
class TimerState with _$TimerState {
  const TimerState._();
  const factory TimerState.initial({required int duration}) =
      _TimerInitialState;
  const factory TimerState.runInProgress({required int duration}) =
      _TimerRunInProgressState;
  const factory TimerState.runComplete() = _TimerRunCompleteState;

  int get duration => when(
        initial: (duration) => duration,
        runInProgress: (duration) => duration,
        runComplete: () => 0,
      );
}
