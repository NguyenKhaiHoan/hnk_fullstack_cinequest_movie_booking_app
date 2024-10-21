part of 'button_bloc.dart';

@freezed
class ButtonEvent with _$ButtonEvent {
  const factory ButtonEvent.execute({
    required UseCase<dynamic, dynamic> useCase,
    dynamic params,
  }) = _ButtonExecuteEvent;
}
