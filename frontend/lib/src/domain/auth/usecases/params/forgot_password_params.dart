import 'package:equatable/equatable.dart';

class ForgotPasswordParams extends Equatable {
  const ForgotPasswordParams({
    required this.email,
  });

  final String email;

  @override
  List<Object?> get props => [
        email,
      ];
}
