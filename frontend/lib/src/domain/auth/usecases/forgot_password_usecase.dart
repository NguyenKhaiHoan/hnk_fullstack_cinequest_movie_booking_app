import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';

class ForgotPasswordUseCase extends UseCase<void, EmailParams> {
  ForgotPasswordUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  FutureEither<void> call({EmailParams? params}) {
    return _authRepository.forgotPassword(params!);
  }
}
