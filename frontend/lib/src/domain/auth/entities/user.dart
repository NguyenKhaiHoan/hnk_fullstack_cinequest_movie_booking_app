import 'package:cinequest/src/domain/auth/entities/role.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.email,
    required this.enabled,
    required this.roles,
    required this.id,
  });

  final String id;
  final String email;
  final bool enabled;
  final Set<Role> roles;

  @override
  List<Object?> get props => [
        id,
        email,
        enabled,
        roles,
      ];
}
