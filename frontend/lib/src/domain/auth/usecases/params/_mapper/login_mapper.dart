import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/login_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';

class LoginMapper implements DomainMapper<LoginRequest, LoginParams> {
  factory LoginMapper() => _instance;
  LoginMapper._();
  static final LoginMapper _instance = LoginMapper._();

  @override
  LoginRequest paramsToRequest(LoginParams params) {
    return LoginRequest(
      email: params.email,
      password: params.password,
    );
  }
}
