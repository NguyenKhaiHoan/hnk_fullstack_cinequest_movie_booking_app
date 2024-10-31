import 'package:cinequest/src/core/extensions/string_extension.dart';
import 'package:cinequest/src/core/generics/mapper.dart';
import 'package:cinequest/src/data/movie/models/review_model.dart';
import 'package:cinequest/src/data/movie/repositories/_mappers/author_details_mapper.dart';
import 'package:cinequest/src/domain/movie/entities/review.dart';

class ReviewMapper implements DataMapper<ReviewModel, Review> {
  factory ReviewMapper() => _instance;
  ReviewMapper._();
  static final ReviewMapper _instance = ReviewMapper._();

  final AuthorDetailsMapper _authorDetailsMapper = AuthorDetailsMapper();

  @override
  Review toEntity(ReviewModel model) {
    return Review(
      author: model.author,
      authorDetails: _authorDetailsMapper.toEntity(model.authorDetails),
      content: model.content,
      createdAt: model.createdAt,
      id: model.id,
      updatedAt: model.updatedAt.timeAgo(),
      url: model.url,
    );
  }

  @override
  ReviewModel toModel(Review entity) {
    throw UnimplementedError();
  }
}
