import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';

class SignUpUseCase extends UseCase<void, SignUpParams> {
  SignUpUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({SignUpParams? params}) {
    return _authRepository.signUp(params!);
  }
}
