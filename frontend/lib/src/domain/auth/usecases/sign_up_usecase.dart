import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/_mappers/sign_up_mapper.dart';
import 'package:cinequest/src/domain/auth/usecases/params/sign_up_params.dart';

class SignUpUseCase extends UseCase<void, SignUpParams> {
  SignUpUseCase(this._authRepository);
  final AuthRepository _authRepository;

  final SignUpMapper _signUpMapper = SignUpMapper();

  @override
  FutureEither<void> call({SignUpParams? params}) {
    final request = _signUpMapper.paramsToRequest(params!);
    return _authRepository.signUp(request);
  }
}
