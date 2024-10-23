import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/forgot_password_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/forgot_password_params.dart';

class ForgotPasswordMapper
    implements DomainMapper<ForgotPasswordRequest, ForgotPasswordParams> {
  factory ForgotPasswordMapper() => _instance;
  ForgotPasswordMapper._();
  static final ForgotPasswordMapper _instance = ForgotPasswordMapper._();

  @override
  ForgotPasswordRequest paramsToRequest(ForgotPasswordParams params) {
    return ForgotPasswordRequest(
      email: params.email,
    );
  }
}
