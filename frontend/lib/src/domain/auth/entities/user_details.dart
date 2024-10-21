import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  const UserDetails({
    required this.id,
    this.username,
    this.name,
    this.surname,
    this.bio,
    this.profilePhoto,
  });
  final String id;
  final String? username;
  final String? name;
  final String? surname;
  final String? bio;
  final String? profilePhoto;

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        surname,
        bio,
        profilePhoto,
      ];
}
