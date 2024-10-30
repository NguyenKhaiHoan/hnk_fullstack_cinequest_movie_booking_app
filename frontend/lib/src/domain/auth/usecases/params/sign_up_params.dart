import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
      ];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
