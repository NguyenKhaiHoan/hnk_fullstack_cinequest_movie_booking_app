import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/_mappers/verify_user_mapper.dart';
import 'package:cinequest/src/domain/auth/usecases/params/verify_user_params.dart';

class VerifyUserUseCase extends UseCase<Token, VerifyUserParams> {
  VerifyUserUseCase(this._authRepository);
  final AuthRepository _authRepository;

  final VerifyUserMapper _verifyUserMapper = VerifyUserMapper();

  @override
  FutureEither<Token> call({VerifyUserParams? params}) {
    final request = _verifyUserMapper.paramsToRequest(params!);
    return _authRepository.verifyUser(request);
  }
}
