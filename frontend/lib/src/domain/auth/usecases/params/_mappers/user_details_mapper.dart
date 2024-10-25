import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/requests/user_details_request.dart';
import 'package:cinequest/src/domain/auth/usecases/params/user_details_params.dart';

class UserDetailsMapper
    implements DomainMapper<UserDetailsRequest, UserDetailsParams> {
  factory UserDetailsMapper() => _instance;
  UserDetailsMapper._();
  static final UserDetailsMapper _instance = UserDetailsMapper._();

  @override
  UserDetailsRequest paramsToRequest(UserDetailsParams params) {
    return UserDetailsRequest(
      username: params.username,
      name: params.name,
      surname: params.surname,
      bio: params.bio,
      profilePhoto: params.profilePhoto,
    );
  }
}
