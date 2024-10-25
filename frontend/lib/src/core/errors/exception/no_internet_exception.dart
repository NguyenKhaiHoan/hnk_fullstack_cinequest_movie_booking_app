import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';

class NoInternetException extends Equatable {
  NoInternetException.fromException() {
    message = 'No internet connection'.hardcoded;
  }

  late final String message;

  @override
  List<Object?> get props => [message];
}
