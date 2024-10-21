import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  GetUserUseCase(this._userRepository);
  final UserRepository _userRepository;

  @override
  FutureEither<User> call({NoParams? params}) {
    return _userRepository.getUser();
  }
}
