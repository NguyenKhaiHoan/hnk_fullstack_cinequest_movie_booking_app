part of 'text_field_bloc.dart';

@freezed
class TextFieldEvent with _$TextFieldEvent {
  const factory TextFieldEvent.toggleVisibility() =
      _TextFieldToggleVisibilityEvent;
}
