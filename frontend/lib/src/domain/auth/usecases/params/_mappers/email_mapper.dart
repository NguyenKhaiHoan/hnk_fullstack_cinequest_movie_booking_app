import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/email_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/email_params.dart';

class EmailMapper implements DomainMapper<EmailRequest, EmailParams> {
  factory EmailMapper() => _instance;
  EmailMapper._();
  static final EmailMapper _instance = EmailMapper._();

  @override
  EmailRequest paramsToRequest(EmailParams params) {
    return EmailRequest(
      email: params.email,
    );
  }
}
