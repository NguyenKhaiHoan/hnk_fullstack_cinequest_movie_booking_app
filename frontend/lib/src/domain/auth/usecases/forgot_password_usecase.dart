import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/_mapper/forgot_password_mapper.dart';
import 'package:cinequest/src/domain/auth/usecases/params/forgot_password_params.dart';

class ForgotPasswordUseCase extends UseCase<void, ForgotPasswordParams> {
  ForgotPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  final ForgotPasswordMapper _forgotPasswordMapper = ForgotPasswordMapper();

  @override
  FutureEither<void> call({ForgotPasswordParams? params}) {
    final request = _forgotPasswordMapper.paramsToRequest(params!);
    return _authRepository.forgotPassword(request);
  }
}
