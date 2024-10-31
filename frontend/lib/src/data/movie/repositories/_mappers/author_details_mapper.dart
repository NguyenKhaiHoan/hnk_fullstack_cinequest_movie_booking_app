import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/author_details_model.dart';
import 'package:cinequest/src/domain/movie/entities/author_detail.dart';

class AuthorDetailsMapper
    implements DataMapper<AuthorDetailsModel, AuthorDetails> {
  factory AuthorDetailsMapper() => _instance;
  AuthorDetailsMapper._();
  static final AuthorDetailsMapper _instance = AuthorDetailsMapper._();

  @override
  AuthorDetails toEntity(AuthorDetailsModel model) {
    return AuthorDetails(
      name: model.name,
      username: model.username,
      avatarPath: model.avatarPath,
      rating: model.rating,
    );
  }

  @override
  AuthorDetailsModel toModel(AuthorDetails entity) {
    throw UnimplementedError();
  }
}
