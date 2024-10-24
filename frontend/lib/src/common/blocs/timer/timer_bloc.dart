import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinequest/src/common/blocs/timer/ticker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_bloc.freezed.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerState.initial(duration: _duration)) {
    on<TimerEvent>((event, emit) {
      event.map(
        started: (e) => _onStarted(e, emit),
        reset: (e) => _onReset(e, emit),
        ticked: (e) => _onTicked(e, emit),
      );
    });
  }

  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(_TimerStartedEvent e, Emitter<TimerState> emit) {
    emit(TimerState.runInProgress(duration: e.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: e.duration)
        .listen((duration) => add(TimerEvent.ticked(duration: duration)));
  }

  void _onTicked(_TimerTickedEvent e, Emitter<TimerState> emit) {
    emit(
      e.duration > 0
          ? TimerState.runInProgress(duration: e.duration)
          : const TimerState.runComplete(),
    );
  }

  void _onReset(_TimerResetEvent e, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerState.initial(duration: _duration));
  }
}
