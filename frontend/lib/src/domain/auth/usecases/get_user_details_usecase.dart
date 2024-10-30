import 'package:cinequest/src/common/entities/user_details.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/user_repository.dart';

class GetUserDetailsUseCase extends UseCase<UserDetails, String> {
  GetUserDetailsUseCase(this._userRepository);
  final UserRepository _userRepository;

  @override
  FutureEither<UserDetails> call({String? params}) {
    return _userRepository.getUserDetails(params!);
  }
}
