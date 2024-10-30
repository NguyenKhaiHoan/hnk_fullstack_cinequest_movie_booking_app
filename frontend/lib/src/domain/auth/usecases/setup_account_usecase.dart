import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/setup_account_params.dart';

class SetupAccountUseCase extends UseCase<UserDetails, SetupAccountParams> {
  SetupAccountUseCase(this._userRepository);
  final UserRepository _userRepository;

  @override
  FutureEither<UserDetails> call({SetupAccountParams? params}) {
    return _userRepository.setupAccount(params!);
  }
}
