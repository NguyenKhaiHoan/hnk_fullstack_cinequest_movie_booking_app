import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/auth/models/requests/forgot_password_request.dart';
import 'package:cinequest/src/data/auth/models/requests/login_request.dart';
import 'package:cinequest/src/data/auth/models/requests/sign_up_request.dart';
import 'package:cinequest/src/data/auth/models/requests/verify_user_request.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';

abstract class AuthRepository {
  FutureEither<void> signUp(SignUpRequest request);
  FutureEither<Token> login(LoginRequest request);
  FutureEither<void> logOut();
  FutureEither<Token> verifyUser(VerifyUserRequest request);
  FutureEither<void> forgotPassword(ForgotPasswordRequest request);
}
