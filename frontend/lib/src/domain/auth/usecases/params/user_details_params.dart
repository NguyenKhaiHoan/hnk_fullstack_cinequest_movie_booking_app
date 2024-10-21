import 'package:equatable/equatable.dart';

class UserDetailsParams extends Equatable {
  const UserDetailsParams({
    required this.username,
    required this.name,
    required this.surname,
    required this.bio,
    required this.profilePhoto,
  });
  final String username;
  final String name;
  final String surname;
  final String bio;
  final String profilePhoto;

  @override
  List<Object?> get props => [
        username,
        name,
        surname,
        bio,
        profilePhoto,
      ];
}
