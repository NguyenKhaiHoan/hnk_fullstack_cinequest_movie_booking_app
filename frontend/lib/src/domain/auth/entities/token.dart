import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({
    required this.accessToken,
    required this.accessTokenExpiresAt,
  });
  final String accessToken;
  final DateTime accessTokenExpiresAt;

  @override
  List<Object?> get props => [
        accessToken,
        accessTokenExpiresAt,
      ];
}
