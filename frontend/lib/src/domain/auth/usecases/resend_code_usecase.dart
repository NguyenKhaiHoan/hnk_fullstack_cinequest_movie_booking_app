import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/domain/auth/repositories/auth_repository.dart';
import 'package:cinequest/src/domain/auth/usecases/params/_mappers/email_mapper.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';

class ResendCodeUseCase extends UseCase<void, EmailParams> {
  ResendCodeUseCase(this._authRepository);
  final AuthRepository _authRepository;

  final EmailMapper _emailMapper = EmailMapper();

  @override
  FutureEither<void> call({EmailParams? params}) {
    final request = _emailMapper.paramsToRequest(params!);
    return _authRepository.resendCode(request);
  }
}
