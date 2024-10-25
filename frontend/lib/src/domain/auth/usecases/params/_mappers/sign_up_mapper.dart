import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/sign_up_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';

class SignUpMapper implements DomainMapper<SignUpRequest, SignUpParams> {
  factory SignUpMapper() => _instance;
  SignUpMapper._();
  static final SignUpMapper _instance = SignUpMapper._();

  @override
  SignUpRequest paramsToRequest(SignUpParams params) {
    return SignUpRequest(
      email: params.email,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}
