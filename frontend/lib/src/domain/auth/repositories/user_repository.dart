import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/data/auth/models/requests/setup_account_request.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';
import 'package:cinequest/src/domain/auth/entities/user_details.dart';

abstract class UserRepository {
  FutureEither<User> getUser();
  FutureEither<UserDetails> getUserDetails(String request);
  FutureEither<UserDetails> setupAccount(SetupAccountRequest request);
}
