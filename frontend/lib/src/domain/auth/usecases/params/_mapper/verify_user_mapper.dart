import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/verify_user_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';

class VerifyUserMapper
    implements DomainMapper<VerifyUserRequest, VerifyUserParams> {
  factory VerifyUserMapper() => _instance;
  VerifyUserMapper._();
  static final VerifyUserMapper _instance = VerifyUserMapper._();

  @override
  VerifyUserRequest paramsToRequest(VerifyUserParams params) {
    return VerifyUserRequest(
      email: params.email,
      verificationCode: params.verificationCode,
    );
  }
}
