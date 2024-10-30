import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/login_params.dart';

class LoginUseCase extends UseCase<Token, LoginParams> {
  LoginUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<Token> call({LoginParams? params}) {
    return _authRepository.login(params!);
  }
}
