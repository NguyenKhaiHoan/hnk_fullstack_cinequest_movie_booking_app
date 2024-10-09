part of 'button_bloc.dart';

/// Các trạng thái
@freezed
class ButtonState with _$ButtonState {
  /// Trạng thái ban đầu
  const factory ButtonState.initial() = _ButtonInitialState;

  /// Trạng thái đang tải
  const factory ButtonState.loading() = _ButtonLoadingState;

  /// Trạng thái thành công khi thực hiện xong use case
  const factory ButtonState.success() = _ButtonSuccessState;

  /// Trạng thái lỗi xảy ra nhận tham số
  ///
  /// - [failure] : lỗi được trả về từ use case
  const factory ButtonState.failure({required Failure failure}) =
      _ButtonFailureState;
}
