import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/auth/models/responses/token_response.dart';
import 'package:cinequest/src/domain/auth/entities/token.dart';

class TokenMapper implements DataMapper<TokenResponse, Token> {
  factory TokenMapper() => _instance;
  TokenMapper._();
  static final TokenMapper _instance = TokenMapper._();

  @override
  Token toEntity(TokenResponse model) {
    return Token(
      accessToken: model.accessToken,
      accessTokenExpiresAt: DateTime.parse(model.accessTokenExpiresAt),
    );
  }

  @override
  TokenResponse toModel(Token entity) {
    return TokenResponse(
      accessToken: entity.accessToken,
      accessTokenExpiresAt: entity.accessTokenExpiresAt.toIso8601String(),
    );
  }
}
