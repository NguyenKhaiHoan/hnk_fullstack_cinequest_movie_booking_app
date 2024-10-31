import 'package:cinequest/src/data/movie/models/author_details_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String author,
    @JsonKey(name: "author_details") required AuthorDetailsModel authorDetails,
    required String content,
    @JsonKey(name: "created_at") required String createdAt,
    required String id,
    @JsonKey(name: "updated_at") required String updatedAt,
    required String url,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
