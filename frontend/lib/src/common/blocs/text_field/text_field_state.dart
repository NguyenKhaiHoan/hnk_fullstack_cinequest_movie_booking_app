part of 'text_field_bloc.dart';

/// Các trạng thái
@freezed
class TextFieldState with _$TextFieldState {
  /// Trạng thái ẩn mật khẩu (mặc định là `true`)
  const factory TextFieldState.obscure({@Default(true) bool obscure}) =
      _TextFieldObscureState;
}
