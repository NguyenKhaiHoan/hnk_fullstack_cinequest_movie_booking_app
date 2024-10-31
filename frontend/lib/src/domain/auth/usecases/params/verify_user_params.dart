import 'package:equatable/equatable.dart';

class VerifyUserParams extends Equatable {
  const VerifyUserParams({
    required this.email,
    required this.verificationCode,
  });

  final String email;
  final String verificationCode;

  @override
  List<Object?> get props => [
        email,
        verificationCode,
      ];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'verification_code': verificationCode,
    };
  }
}
