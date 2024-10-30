import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/user_details_model.dart';
import 'package:cinequest/src/common/entities/user_details.dart';

class UserDetailsMapper implements DataMapper<UserDetailsModel, UserDetails> {
  factory UserDetailsMapper() => _instance;
  UserDetailsMapper._();
  static final UserDetailsMapper _instance = UserDetailsMapper._();

  @override
  UserDetails toEntity(UserDetailsModel model) {
    return UserDetails(
      id: model.id,
      username: model.username,
      name: model.name,
      surname: model.surname,
      bio: model.bio,
      profilePhoto: model.profilePhoto,
    );
  }

  @override
  UserDetailsModel toModel(UserDetails entity) {
    return UserDetailsModel(
      id: entity.id,
      username: entity.username,
      name: entity.name,
      surname: entity.surname,
      bio: entity.bio,
      profilePhoto: entity.profilePhoto,
    );
  }
}
