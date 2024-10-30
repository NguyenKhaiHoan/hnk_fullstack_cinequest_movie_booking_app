import 'package:freezed_annotation/freezed_annotation.dart';

part 'genre_with_image_model.freezed.dart';
part 'genre_with_image_model.g.dart';

@freezed
class GenreWithImageModel with _$GenreWithImageModel {
  const factory GenreWithImageModel({
    required int id,
    required String name,
    required String image,
  }) = _GenreWithImageModel;

  factory GenreWithImageModel.fromJson(Map<String, dynamic> json) =>
      _$GenreWithImageModelFromJson(json);
}
