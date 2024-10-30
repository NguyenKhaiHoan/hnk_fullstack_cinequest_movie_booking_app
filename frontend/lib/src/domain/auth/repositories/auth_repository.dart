import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';

abstract class AuthRepository {
  FutureEither<void> signUp(SignUpParams params);
  FutureEither<Token> login(LoginParams params);
  FutureEither<void> logOut();
  FutureEither<Token> verifyUser(VerifyUserParams params);
  FutureEither<void> forgotPassword(EmailParams params);
  FutureEither<void> resendCode(EmailParams params);
}
