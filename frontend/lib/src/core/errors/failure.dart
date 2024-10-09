import 'package:equatable/equatable.dart';

/// Lỗi chung được sử dụng cho App
class Failure with EquatableMixin implements Exception {
  /// Contructor
  Failure({
    required this.message,
    this.exception,
    this.stackTrace = StackTrace.empty,
  });

  final String message;

  final Exception? exception;

  final StackTrace stackTrace;

  @override
  List<dynamic> get props => [message, exception, stackTrace];

  @override
  bool? get stringify => true;
}
