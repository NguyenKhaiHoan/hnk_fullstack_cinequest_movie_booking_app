import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';
import 'package:cinequest/src/domain/auth/usecases/params/setup_account_params.dart';

abstract class UserRepository {
  FutureEither<User> getUser();
  FutureEither<UserDetails> getUserDetails(String params);
  FutureEither<UserDetails> setupAccount(SetupAccountParams params);
}
