import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_details_model.freezed.dart';
part 'author_details_model.g.dart';

@freezed
class AuthorDetailsModel with _$AuthorDetailsModel {
  const factory AuthorDetailsModel({
    required String name,
    required String username,
    @JsonKey(name: "avatar_path") required String avatarPath,
    required int rating,
  }) = _AuthorDetailsModel;

  factory AuthorDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorDetailsModelFromJson(json);
}
