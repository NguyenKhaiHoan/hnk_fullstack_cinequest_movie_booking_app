import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/user_model.dart';
import 'package:cinequest/src/data/auth/repositories/_mappers/role_mapper.dart';
import 'package:cinequest/src/domain/auth/entities/user.dart';

class UserMapper implements DataMapper<UserModel, User> {
  factory UserMapper() => _instance;
  UserMapper._();
  static final UserMapper _instance = UserMapper._();

  final _roleMapper = RoleMapper();

  @override
  User toEntity(UserModel model) {
    return User(
      id: model.id,
      email: model.email,
      enabled: model.enabled,
      roles: model.roles.map(_roleMapper.toEntity).toSet(),
    );
  }

  @override
  UserModel toModel(User entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      enabled: entity.enabled,
      roles: entity.roles.map(_roleMapper.toModel).toSet(),
    );
  }
}
