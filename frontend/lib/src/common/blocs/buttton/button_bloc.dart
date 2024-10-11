import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'button_bloc.freezed.dart';
part 'button_event.dart';
part 'button_state.dart';

/// Quản lý trạng thái của Button khi thực hiện các use case
class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  /// Constructor
  ButtonBloc() : super(const ButtonState.initial()) {
    on<ButtonEvent>((events, emit) async {
      await events.map(
        execute: (event) async => _onExecute(
          event,
          emit,
          params: event.params,
          useCase: event.useCase,
        ),
      );
    });
  }

  Future<void> _onExecute(
    _ButtonExecuteEvent event,
    Emitter<ButtonState> emit, {
    required UseCase<dynamic, dynamic> useCase,
    dynamic params,
  }) async {
    emit(const ButtonState.loading());
    final result = await useCase.call(params: params);

    result.fold((failure) {
      emit(ButtonState.failure(failure: failure));
    }, (data) {
      emit(const ButtonState.success());
    });
  }
}
