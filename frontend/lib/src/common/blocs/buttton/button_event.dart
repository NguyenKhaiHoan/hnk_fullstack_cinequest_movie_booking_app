part of 'button_bloc.dart';

/// Các sự kiện
@freezed
class ButtonEvent with _$ButtonEvent {
  /// Sự kiện thực hiện các use case khi được truyền vào nhận tham số
  ///
  /// - [useCase] : Use case cần thực hiện
  /// - [params] : Tham số cần thiết cho use case
  const factory ButtonEvent.execute({
    required FutureAsyncUseCase<dynamic, dynamic> useCase,
    dynamic params,
  }) = _ButtonExecuteEvent;
}
