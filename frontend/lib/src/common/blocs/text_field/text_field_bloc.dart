import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_event.dart';
part 'text_field_state.dart';
part 'text_field_bloc.freezed.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(const TextFieldState.obscure()) {
    on<TextFieldEvent>((event, emit) async {
      event.map(
        toggleVisibility: (e) => _onToggleVisibility(e, emit),
      );
    });
  }

  void _onToggleVisibility(
    _TextFieldToggleVisibilityEvent event,
    Emitter<TextFieldState> emit,
  ) {
    emit(TextFieldState.obscure(obscure: !state.obscure));
  }
}
