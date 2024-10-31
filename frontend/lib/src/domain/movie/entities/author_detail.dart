import 'package:equatable/equatable.dart';

class AuthorDetails extends Equatable {
  const AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  final String name;
  final String username;
  final String avatarPath;
  final int rating;

  @override
  List<Object?> get props => [
        name,
        username,
        avatarPath,
        rating,
      ];
}
