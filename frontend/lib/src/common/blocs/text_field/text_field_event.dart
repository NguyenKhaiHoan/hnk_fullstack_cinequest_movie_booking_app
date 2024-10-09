part of 'text_field_bloc.dart';

/// Các sự kiện
@freezed
class TextFieldEvent with _$TextFieldEvent {
  /// Sự kiện bật/tắt ẩn mật khẩu
  const factory TextFieldEvent.toggleVisibility() =
      _TextFieldToggleVisibilityEvent;
}
