import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/role_model.dart';
import 'package:cinequest/src/domain/auth/entities/role.dart';

class RoleMapper implements DataMapper<RoleModel, Role> {
  factory RoleMapper() => _instance;
  RoleMapper._();
  static final RoleMapper _instance = RoleMapper._();

  @override
  Role toEntity(RoleModel model) {
    return Role(name: model.name, description: model.description);
  }

  @override
  RoleModel toModel(Role entity) {
    return RoleModel(
      name: entity.name,
      description: entity.description,
    );
  }
}
